output "id" {
  description = "returns a string"
  value       = aws_lakeformation_resource.lakeformation.id
}

output "last_modified" {
  description = "returns a string"
  value       = aws_lakeformation_resource.lakeformation.last_modified
}

output "role_arn" {
  description = "returns a string"
  value       = aws_lakeformation_resource.lakeformation.role_arn
}

output "lakeformation" {
  value = aws_lakeformation_resource.lakeformation
}