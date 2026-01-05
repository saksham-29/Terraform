variable "env" {
  description = "The environment for the VPC (e.g., dev, prod)"
  type        = string
}

variable "db_name" {
  description = "The name of the database to create"
  type        = string
}

variable "db_username" {
  description = "The username for the database"
  type        = string
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "The instance class for the RDS database"
  type        = string
}

variable "db_subnet_ids" {
  description = "A list of subnet IDs for the RDS database"
  type        = list(string)
}

variable "db_sg_ids" {
  description = "A list of security group IDs for the RDS database"
  type        = string
}