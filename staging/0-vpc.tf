resource "aws_vpc" "tf_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "${var.app_name}-VPC"
  }
}

resource "aws_subnet" "tf_vpc_sub_a1" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "${var.app_name}-VPC-Subnet-1-App"
  }
}

resource "aws_subnet" "tf_vpc_sub_a2" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "${var.app_name}-VPC-Subnet-2-App"
  }
}

resource "aws_subnet" "tf_vpc_sub_b1" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "${var.app_name}-VPC-Subnet-1-DB"
  }
}

resource "aws_subnet" "tf_vpc_sub_b2" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.0.11.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "${var.app_name}-VPC-Subnet-2-DB"
  }
}

resource "aws_subnet" "tf_vpc_sub_c1" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.0.20.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "${var.app_name}-VPC-Subnet-1-Web"
  }
}

resource "aws_subnet" "tf_vpc_sub_c2" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.0.21.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "${var.app_name}-VPC-Subnet-2-Web"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "${var.app_name} Internet Gateway"
  }
}

resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.tf_vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}