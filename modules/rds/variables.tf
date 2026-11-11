variable "project_name" {
  type        = string
  description = "Project prefix for resource naming"
}

variable "environment" {
  type        = string
  description = "Deployment environment (e.g., dev, prod)"
}

variable "availability_zone" {
  type        = string
  description = "Single AZ to lock the RDS instance into"
}

variable "db_subnet_group_name" {
  type        = string
  description = "Name of the DB subnet group"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of VPC security group IDs"
}

variable "db_username" {
  type        = string
  sensitive   = true
  description = "Master username for MySQL"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "Master password for MySQL"
}

variable "kms_key_id" {
  type        = string
  default     = null
  description = "Optional Customer Managed Key (CMK) ARN for encryption at rest"
}
