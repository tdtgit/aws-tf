resource "aws_security_group" "tf-elb-web-sg" {
  name        = "${var.app_name}-SG-Web-ELB"
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
    Name        = "${var.app_name}-SG-WEB-ELB"
    Environment = var.environment
  }
}

resource "aws_security_group" "tf-web-sg" {
  name        = "${var.app_name}-SG-WEB"
  description = "Allow ELB inbound traffic"
  vpc_id      = aws_vpc.tf_vpc.id

  ingress {
    description     = "HTTP"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [
      aws_security_group.tf-elb-web-sg.id
    ]
  }

  ingress {
    description     = "HTTPs"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [
      aws_security_group.tf-elb-web-sg.id
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
    Name        = "${var.app_name}-SG-WEB"
    Environment = var.environment
  }
}

resource "aws_security_group" "tf-elb-app-sg" {
  name        = "${var.app_name}-SG-APP-ELB"
  description = "Allow inbound traffic from Web instances"
  vpc_id      = aws_vpc.tf_vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [
      aws_security_group.tf-web-sg.id
    ]
  }

  ingress {
    description = "HTTPs"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [
      aws_security_group.tf-web-sg.id
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
    Name        = "${var.app_name}-SG-APP-ELB"
    Environment = var.environment
  }
}

resource "aws_security_group" "tf-app-sg" {
  name        = "${var.app_name}-SG-APP"
  description = "Allow inbound traffic from Web instances"
  vpc_id      = aws_vpc.tf_vpc.id

  ingress {
    description     = "HTTP"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [
      aws_security_group.tf-elb-app-sg.id
    ]
  }

  ingress {
    description     = "HTTPs"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [
      aws_security_group.tf-elb-app-sg.id
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