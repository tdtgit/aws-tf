# App
resource "aws_lb" "app_elb" {
  name               = "${var.app_name}-app-elb"
  internal           = true
  load_balancer_type = "application"
  security_groups = [
    aws_security_group.app_elb_sg.id
  ]
  subnets = [
    aws_subnet.app_1a.id,
    aws_subnet.app_1b.id
  ]

  access_logs {
    bucket  = aws_s3_bucket.elb_logs_s3.bucket
    prefix  = var.elb_log_prefix.private
    enabled = true
  }

  tags = {
    Name        = "${var.app_name}_app_elb"
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "app_elb_tg" {
  name     = "${var.app_name}-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id

  tags = {
    Name        = "${var.app_name}-app-tg"
    Environment = var.environment
  }
}

resource "aws_lb_listener" "app_elb_listener" {
  load_balancer_arn = aws_lb.app_elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_elb_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "app_elb_tg_target_app" {
  count            = length(aws_instance.app_ec2)
  target_group_arn = aws_lb_target_group.app_elb_tg.arn
  target_id        = aws_instance.app_ec2[count.index].id
  port             = 80
}

# Web
resource "aws_lb" "web_elb" {
  name               = "${var.app_name}-web-elb"
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    aws_security_group.web_elb_sg.id
  ]
  subnets = [
    aws_subnet.web_1a.id,
    aws_subnet.web_1b.id
  ]

  access_logs {
    bucket  = aws_s3_bucket.elb_logs_s3.bucket
    prefix  = var.elb_log_prefix.public
    enabled = true
  }

  tags = {
    Name        = "${var.app_name}_web_elb"
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "web_elb_tg" {
  name     = "${var.app_name}-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id

  tags = {
    Name        = "${var.app_name}-web-tg"
    Environment = var.environment
  }
}

resource "aws_lb_listener" "web_elb_listener" {
  load_balancer_arn = aws_lb.web_elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_elb_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "web_elb_tg_target_web" {
  count            = length(aws_instance.web_ec2)
  target_group_arn = aws_lb_target_group.web_elb_tg.arn
  target_id        = aws_instance.web_ec2[count.index].id
  port             = 80
}