resource "aws_db_subnet_group" "main" {
  name       = "${var.env}-rds-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name        = "${var.env}-rds-subnet-group"
    Environment = var.env
  }
}

resource "aws_db_instance" "main" {
  identifier            = "${var.env}-rds-instance"
  allocated_storage     = 20
  engine                = "postgres"
  engine_version        = "15"
  instance_class        = var.db_instance_class
  max_allocated_storage = 100

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  multi_az                = true
  publicly_accessible     = false
  storage_encrypted       = true
  backup_retention_period = 7
  deletion_protection     = true

  vpc_security_group_ids = [var.db_sg_ids]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  skip_final_snapshot       = true
  final_snapshot_identifier = "${var.env}-rds-final-snapshot"

  tags = {
    Name        = "${var.env}-rds-instance"
    Environment = var.env
  }
}