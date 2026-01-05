resource "aws_iam_role" "ec2_role" {
  name = "${var.env}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    Environment = var.env
    Name = "${var.env}-ec2-role"
  }
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "main" {
  name = "${var.env}-ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_instance" "app" {
    count = length(var.private_subnet_ids)

    ami           = var.ami_id
    instance_type = var.instance_type
    subnet_id     = var.private_subnet_ids[count.index]
    vpc_security_group_ids = [var.app_sg_id]
    iam_instance_profile = aws_iam_instance_profile.main.name
    associate_public_ip_address = false

    user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "OK - ${var.env} instance $(hostname)" > /var/www/html/index.html
              EOF

    tags = {
        Name        = "${var.env}-app-instance-${count.index + 1}"
        Environment = var.env
    }
}

resource "aws_lb_target_group_attachment" "app" {
    count            = length(aws_instance.app)
    target_group_arn = var.target_group_arn
    target_id        = aws_instance.app[count.index].id
    port             = 80
}