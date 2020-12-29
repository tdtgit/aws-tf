# ELB security group
resource "aws_security_group" "elb_sg" {
  name        = "${var.app_name} ELB SG"
  description = "Allow HTTP/HTTPs traffic"
  vpc_id      = aws_vpc.tf_vpc.id

  ingress {
    description = "HTTPs traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name        = "${var.app_name} ELB SG"
    Environment = var.environment
  }
}

# EC2 App instances security group
resource "aws_security_group" "app_sg" {
  name        = "${var.app_name} App SG"
  description = "Allow traffic from ELB"
  vpc_id      = aws_vpc.tf_vpc.id

  ingress {
    description = "HTTPs traffic from ELB"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.elb_sg.id]
  }

  ingress {
    description = "HTTP traffic from ELB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.elb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name        = "${var.app_name} EC2 SG"
    Environment = var.environment
  }
}