resource "aws_lb" "tf-elb" {
  name               = "${var.app_name}-ELB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [
    aws_security_group.tf-elb-sg.id
  ]
  subnets            = [
    aws_subnet.tf_vpc_sub_c2.id,
    aws_subnet.tf_vpc_sub_c1.id
  ]

  access_logs {
    bucket  = aws_s3_bucket.tf-s3.bucket
    prefix  = var.s3_prefix
    enabled = true
  }

  tags = {
    Name        = "${var.app_name}-ELB"
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "tf-elb-tg" {
  name     = "${var.app_name}-ELB-TargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.tf_vpc.id

  tags = {
    Name        = "${var.app_name}-ELB-TargetGroup"
    Environment = var.environment
  }
}

resource "aws_lb_listener" "tf-elb-listener" {
  load_balancer_arn = aws_lb.tf-elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tf-elb-tg.arn
  }
}

resource "aws_lb_target_group_attachment" "tf-elb-tg-target-app1" {
  target_group_arn = aws_lb_target_group.tf-elb-tg.arn
  target_id        = aws_instance.tf_ec2_app1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tf-elb-tg-target-app2" {
  target_group_arn = aws_lb_target_group.tf-elb-tg.arn
  target_id        = aws_instance.tf_ec2_app2.id
  port             = 80
}