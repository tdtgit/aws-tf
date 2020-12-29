resource "aws_lb" "tf_elb" {
  name               = "${var.app_name}-ELB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = [aws_subnet.tf_vpc_sub_c2.id,aws_subnet.tf_vpc_sub_c1.id]

  access_logs {
    bucket  = aws_s3_bucket.tf_app.bucket
    prefix  = "pub-elb"
    enabled = true
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "tf_elb_tg" {
  name     = "${var.app_name}-Public-ELB-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.tf_vpc.id

  stickiness {
    type = "lb_cookie"
    enabled = "true"
  }
}

resource "aws_lb_target_group_attachment" "tf_elb_public_tg_app1" {
  target_group_arn = aws_lb_target_group.tf_elb_tg.arn
  target_id        = aws_instance.tf_ec2_app1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tf_elb_public_tg_app2" {
  target_group_arn = aws_lb_target_group.tf_elb_tg.arn
  target_id        = aws_instance.tf_ec2_app2.id
  port             = 80
}

resource "aws_lb_listener" "tf_http_listener" {
  load_balancer_arn = aws_lb.tf_elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tf_elb_tg.arn
  }
}