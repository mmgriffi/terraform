output "db_endpoint" {
  value       = aws_db_instance.mysql_db.endpoint
  description = "Connection endpoint for the MySQL database"
}

output "db_arn" {
  value       = aws_db_instance.mysql_db.arn
  description = "ARN of the MySQL database"
}
