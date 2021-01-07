# App
resource "aws_lb" "tf-app-elb" {
  name               = "${var.app_name}-ELB-App"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [
    aws_security_group.tf-elb-app-sg.id
  ]
  subnets            = [
    aws_subnet.tf_vpc_sub_a1.id,
    aws_subnet.tf_vpc_sub_a2.id
  ]

  access_logs {
    bucket  = aws_s3_bucket.tf-s3.bucket
    prefix  = var.lb_private_s3_prefix
    enabled = true
  }

  tags = {
    Name        = "${var.app_name}-ELB-App"
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "tf-app-elb-tg" {
  name     = "${var.app_name}-ELB-App-TargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.tf_vpc.id

  tags = {
    Name        = "${var.app_name}-ELB-App-TargetGroup"
    Environment = var.environment
  }
}

resource "aws_lb_listener" "tf-app-elb-listener" {
  load_balancer_arn = aws_lb.tf-app-elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tf-app-elb-tg.arn
  }
}

resource "aws_lb_target_group_attachment" "tf-app-elb-tg-target-app1" {
  target_group_arn = aws_lb_target_group.tf-app-elb-tg.arn
  target_id        = aws_instance.tf_ec2_app1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tf-elb-tg-target-app2" {
  target_group_arn = aws_lb_target_group.tf-app-elb-tg.arn
  target_id        = aws_instance.tf_ec2_app2.id
  port             = 80
}

# Web
resource "aws_lb" "tf-web-elb" {
  name               = "${var.app_name}-ELB-Web"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [
    aws_security_group.tf-elb-web-sg.id
  ]
  subnets            = [
    aws_subnet.tf_vpc_sub_c1.id,
    aws_subnet.tf_vpc_sub_c2.id
  ]

  access_logs {
    bucket  = aws_s3_bucket.tf-s3.bucket
    prefix  = var.lb_public_s3_prefix
    enabled = true
  }

  tags = {
    Name        = "${var.app_name}-ELB-Web"
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "tf-web-elb-tg" {
  name     = "${var.app_name}-ELB-Web-TargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.tf_vpc.id

  tags = {
    Name        = "${var.app_name}-ELB-Web-TargetGroup"
    Environment = var.environment
  }
}

resource "aws_lb_listener" "tf-web-elb-listener" {
  load_balancer_arn = aws_lb.tf-web-elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tf-web-elb-tg.arn
  }
}

resource "aws_lb_target_group_attachment" "tf-web-elb-tg-target-app1" {
  target_group_arn = aws_lb_target_group.tf-web-elb-tg.arn
  target_id        = aws_instance.tf_ec2_web1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tf-web-elb-tg-target-app2" {
  target_group_arn = aws_lb_target_group.tf-web-elb-tg.arn
  target_id        = aws_instance.tf_ec2_web2.id
  port             = 80
}