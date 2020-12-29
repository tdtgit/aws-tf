resource "aws_vpc" "tf_vpc" {
  cidr_block = "172.29.0.0/16"

  tags = {
    Name = "${var.app_name}-VPC"
    Environment = var.environment
  }
}

resource "aws_subnet" "tf_vpc_sub_a1" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "172.29.16.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.app_name}-VPC-Subnet-1-App"
    Environment = var.environment
  }
}

resource "aws_subnet" "tf_vpc_sub_a2" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "172.29.17.0/24"
  availability_zone = "${var.region}b"

  tags = {
    Name = "${var.app_name}-VPC-Subnet-2-App"
    Environment = var.environment
  }
}

resource "aws_subnet" "tf_vpc_sub_b1" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "172.29.25.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.app_name}-VPC-Subnet-1-DB"
    Environment = var.environment
  }
}

resource "aws_subnet" "tf_vpc_sub_b2" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "172.29.26.0/24"
  availability_zone = "${var.region}b"

  tags = {
    Name = "${var.app_name}-VPC-Subnet-2-DB"
    Environment = var.environment
  }
}

resource "aws_subnet" "tf_vpc_sub_c1" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "172.29.34.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.app_name}-VPC-Subnet-1-Web"
    Environment = var.environment
  }
}

resource "aws_subnet" "tf_vpc_sub_c2" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "172.29.35.0/24"
  availability_zone = "${var.region}b"

  tags = {
    Name = "${var.app_name}-VPC-Subnet-2-Web"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "${var.app_name} Internet Gateway"
    Environment = var.environment
  }
}

resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.tf_vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.app_name} RTB"
    Environment = var.environment
  }
}