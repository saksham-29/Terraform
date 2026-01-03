output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = aws_alb.main.arn
}
output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_alb.main.dns_name
}
output "alb_target_group_arn" {
  description = "The ARN of the ALB Target Group"
  value       = aws_alb_target_group.main.arn
}