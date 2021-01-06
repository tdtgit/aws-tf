resource "aws_vpc" "tf_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    name = "${var.app_name}-VPC"
  }
}

resource "aws_subnet" "tf_vpc_sub_a1" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    name = "${var.app_name}-VPC-Subnet-1-App"
  }
}

resource "aws_subnet" "tf_vpc_sub_a2" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    name = "${var.app_name}-VPC-Subnet-2-App"
  }
}

resource "aws_subnet" "tf_vpc_sub_b1" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    name = "${var.app_name}-VPC-Subnet-1-DB"
  }
}

resource "aws_subnet" "tf_vpc_sub_b2" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.0.11.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    name = "${var.app_name}-VPC-Subnet-2-DB"
  }
}

resource "aws_subnet" "tf_vpc_sub_c1" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.0.20.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    name = "${var.app_name}-VPC-Subnet-1-Web"
  }
}

resource "aws_subnet" "tf_vpc_sub_c2" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.0.21.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    name = "${var.app_name}-VPC-Subnet-2-Web"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    name = "${var.app_name} Internet Gateway"
  }
}

resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.tf_vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_security_group" "tf-elb-sg" {
  name        = "${var.app_name}-SG-ELB"
  description = "Allow global inbound traffic"
  vpc_id      = aws_vpc.tf_vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPs"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPs"
    from_port   = 443
    to_port     = 443
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name        = "${var.app_name}-SG-ELB"
  }
}

resource "aws_security_group" "tf-app-sg" {
  name        = "${var.app_name}-SG-APP"
  description = "Allow ELB inbound traffic"
  vpc_id      = aws_vpc.tf_vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.tf-elb-sg.id]
  }

  ingress {
    description = "HTTPs"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.tf-elb-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name        = "${var.app_name}-SG-APP"
  }
}

resource "aws_security_group" "tf-db-sg" {
  name        = "${var.app_name}-SG-DB"
  description = "Allow traffic from APP"
  vpc_id      = aws_vpc.tf_vpc.id

  ingress {
    description = "MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.tf-app-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name        = "${var.app_name}-SG-DB"
  }
}