resource "aws_db_instance" "mysql_db" {
  identifier              = "${var.project_name}-mysql"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  skip_final_snapshot     = true
  backup_retention_period = 0

  # Digital Sovereignty & Encryption at Rest
  storage_encrypted = true
  kms_key_id        = var.kms_key_id

  # Constraints: Forces DB into a single AZ and disables replication
  availability_zone = var.availability_zone
  multi_az          = false

  # Networking & Security (passed in via module variables)
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids

  # Credentials
  username = var.db_username
  password = var.db_password

  tags = {
    Name        = "${var.project_name}-mysql-db"
    Environment = var.environment
  }
}
