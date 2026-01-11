variable "env" {
  description = "The environment name (e.g., dev, prod)"
  type        = string
}

variable "email" {
  description = "The email address to send alerts to"
  type        = string
}
variable "asg_name" {
  description = "The name of the Auto Scaling Group"
  type        = string
}
variable "alb_arn_suffix" {
  description = "The ARN suffix for the Application Load Balancer"
  type        = string
}
variable "target_group_arn_suffix" {
  description = "The ARN suffix for the Target Group"
  type        = string
}