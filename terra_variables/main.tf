terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.69"
    }
  }
  required_version = ">= 1.16.3"
}

provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}
resource "aws_s3_bucket" "demo" {
    bucket = var.s3_bucket_config.bucket_name
    
    tags = {
        name = var.s3_bucket_config.bucket_name
        environment  = var.s3_bucket_config.environment
    }
}
resource "aws_s3_bucket_versioning" "demo" {
    bucket = aws_s3_bucket.demo.id

    versioning_configuration {
        status = var.s3_bucket_config.versioning_enabled ? "Enabled" : "Suspended"
    }
}
output "bucket_name" {
    description = "The name of the created S3 bucket"
    value = aws_s3_bucket.demo.bucket 
}
output "bucket_arm" {
    description = "the ARN of the created bucket"
    value = aws_s3_bucket.demo.arn
}
