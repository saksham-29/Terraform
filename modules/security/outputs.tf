output "alb_security_group_id" {
    value = aws_security_group.alb.id
}

output "app_security_group_id" {
    value = aws_security_group.app.id
}

output "db_security_group_id" {
    value = aws_security_group.db.id
}

output "alb_sg_id" {
  value = aws_security_group.alb.id
}

output "app_sg_id" {
  value = aws_security_group.app.id
}

output "db_sg_ids" {
  value = aws_security_group.db.id
}