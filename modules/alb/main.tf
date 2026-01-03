resource "aws_lb" "main" {
  name               = "alb-${var.env}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnet_ids

  tags = {
    Environment = var.env
    Name        = "alb-${var.env}"
  }
}

resource "aws_lb_target_group" "main" {
  name     = "tg-${var.env}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    matcher             = "200-399"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    protocol = "HTTP"
  }

  tags = {
    Environment = var.env
    Name        = "tg-${var.env}"
  }
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}