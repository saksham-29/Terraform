variable "env" {
  description = "environment name"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the ALB will be deployed"
  type        = string
}

variable "public_subnet_ids" {
  description = "The list of subnet IDs where the ALB will be deployed"
  type        = list(string)
}

variable "alb_sg_id" {
  description = "The security group ID to associate with the ALB"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the ACM certificate"
  type        = string
}

variable "hosted_zone_name" {
  type        = string
  description = "Route53 hosted zone name (e.g. example.com)"
}
