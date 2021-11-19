terraform {
  required_version = ">= 0.12.0"
}

resource "aws_lakeformation_resource" "lakeformation" {
  arn = var.arn
  role_arn = var.role_arn
}
