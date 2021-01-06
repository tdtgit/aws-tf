resource "aws_security_group" "tf-elb-sg" {
  name        = "${var.app_name}-SG-ELB"
  description = "Allow global inbound traffic"
  vpc_id      = aws_vpc.tf_vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  ingress {
    description = "HTTPs"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  ingress {
    description = "HTTPs"
    from_port   = 443
    to_port     = 443
    protocol    = "udp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name        = "${var.app_name}-SG-ELB"
    Environment = var.environment
  }
}

resource "aws_security_group" "tf-app-sg" {
  name        = "${var.app_name}-SG-APP"
  description = "Allow ELB inbound traffic"
  vpc_id      = aws_vpc.tf_vpc.id

  ingress {
    description     = "HTTP"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [
      aws_security_group.tf-elb-sg.id
    ]
  }

  ingress {
    description     = "HTTPs"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [
      aws_security_group.tf-elb-sg.id
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name        = "${var.app_name}-SG-APP"
    Environment = var.environment
  }
}

resource "aws_security_group" "tf-db-sg" {
  name        = "${var.app_name}-SG-DB"
  description = "Allow traffic from APP"
  vpc_id      = aws_vpc.tf_vpc.id

  ingress {
    description     = "MySQL"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [
      aws_security_group.tf-app-sg.id
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name        = "${var.app_name}-SG-DB"
    Environment = var.environment
  }
}