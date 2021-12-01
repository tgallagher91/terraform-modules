data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
# data storage configuration resources
resource "aws_s3_bucket" "connect" {
  bucket = "amazon-connect-${var.connect-instance-alias}-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    ConnectInstanceAlias = var.connect-instance-alias
  }
  versioning {
    enabled = true
  }
}
resource "aws_s3_bucket_policy" "connect" {
  depends_on = [
    aws_s3_bucket_public_access_block.connect
  ]
  bucket = aws_s3_bucket.connect.id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "DefaultBucketPolicy"
    Statement = [
      {
        Sid       = "DenyNonHttpsAccess"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          "${aws_s3_bucket.connect.arn}",
          "${aws_s3_bucket.connect.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}
resource "aws_s3_bucket_public_access_block" "connect" {
  bucket                  = aws_s3_bucket.connect.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_kms_key" "connect" {
  description             = "${var.connect-instance-alias}-${data.aws_region.current.name} Amazon Connect Key"
  deletion_window_in_days = 30
  enable_key_rotation     = true
  tags = {
    ConnectInstanceAlias = var.connect-instance-alias
  }
  policy = data.aws_iam_policy_document.connect_key_policy.json
}
data "aws_iam_policy_document" "connect_key_policy" {
  statement {
    sid    = "Allow Administrator Access to administer the key"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions = [
      "kms:*"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "Allow access through Connect for all principals in the account that are authorized to use Connect"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "kms:CreateGrant",
      "kms:Describe*",
      "kms:Get*",
      "kms:List*"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = ["${data.aws_caller_identity.current.account_id}"]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values   = ["connect.${data.aws_region.current.name}.amazonaws.com"]
    }
  }
  statement {
    sid    = "Allow Connect to directly describe the key"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["connect.amazonaws.com"]
    }
    actions = [
      "kms:Describe*",
      "kms:Get*",
      "kms:List*"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "Allow direct access to key metadata to the account"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions = [
      "kms:Describe*",
      "kms:Get*",
      "kms:List*",
      "kms:RevokeGrant"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "Restrict direct usage"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "kms:Encrypt",
      "kms:GenerateDataKey",
      "kms:ReEncrypt*"
    ]
    resources = ["*"]
    condition {
      test     = "Null"
      variable = "kms:ViaService"
      values   = ["true"]
    }
  }
  statement {
    sid    = "Restrict usage to Connect data"
    effect = "Deny"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "kms:Encrypt",
      "kms:GenerateDataKey*",
      "kms:ReEncrypt*"
    ]
    resources = ["*"]
    condition {
      test     = "Null"
      variable = "kms:EncryptionContext:aws:connect:OrganizationId"
      values   = ["true"]
    }
  }
  statement {
    sid    = "Allow access through S3 for all principals in the account that are authorized to use S3"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "kms:Decrypt"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = ["${data.aws_caller_identity.current.account_id}"]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values   = ["s3.${data.aws_region.current.name}.amazonaws.com"]
    }
  }
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "kms:Decrypt"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = ["${data.aws_caller_identity.current.account_id}"]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values   = ["kinesisvideo.${data.aws_region.current.name}.amazonaws.com"]
    }
  }
}
# resource "aws_kms_grant" "connect" {
#   key_id            = aws_kms_key.connect.key_id
#   grantee_principal = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/macie.amazonaws.com/AWSServiceRoleForAmazonMacie"
#   operations        = ["Decrypt"]
#   name              = "macie"
# }
resource "aws_kms_alias" "connect" {
  name          = "alias/${var.connect-instance-alias}/connect-cmk"
  target_key_id = aws_kms_key.connect.key_id
}
# data streaming configuration resources
resource "aws_s3_bucket" "firehose" {
  bucket = "amazon-connect-${var.connect-instance-alias}-${data.aws_caller_identity.current.account_id}-firehose-${data.aws_region.current.name}"
  acl    = "private"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    ConnectInstanceAlias = var.connect-instance-alias
  }
  versioning {
    enabled = true
  }
}
resource "aws_s3_bucket_policy" "firehose" {
  depends_on = [
    aws_s3_bucket_public_access_block.firehose
  ]
  bucket = aws_s3_bucket.firehose.id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "DefaultBucketPolicy"
    Statement = [
      {
        Sid       = "DenyNonHttpsAccess"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          "${aws_s3_bucket.firehose.arn}",
          "${aws_s3_bucket.firehose.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}
resource "aws_s3_bucket_public_access_block" "firehose" {
  bucket                  = aws_s3_bucket.firehose.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_kinesis_firehose_delivery_stream" "firehose" {
  name        = "${var.connect-instance-alias}-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}-firehose-stream"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose.arn
    bucket_arn = aws_s3_bucket.firehose.arn

    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = "/firehose/${var.connect-instance-alias}"
      log_stream_name = "connect-firehose"
    }
  }
  tags = {
    ConnectInstanceAlias = var.connect-instance-alias
  }
}
resource "aws_iam_role" "firehose" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Id      = "ConnectFirehoseRole"
    Statement = [{
      Sid    = "AllowFirehoseAssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "firehose.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}
resource "aws_connect_instance" "connect" {
  identity_management_type = "CONNECT_MANAGED"
  inbound_calls_enabled    = true
  instance_alias           = var.connect-instance-alias
  outbound_calls_enabled   = true
}