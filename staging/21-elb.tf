resource "aws_lb" "tf-elb" {
  name               = "${var.app_name}-ELB"
  internal           = false
  load_balancer_type = "application"
  # security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.tf_vpc_sub_c2.id,aws_subnet.tf_vpc_sub_c1.id]

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.tf-app.bucket
    prefix  = "elb"
    enabled = true
  }

  tags = {
    Environment = "dev"
  }
}