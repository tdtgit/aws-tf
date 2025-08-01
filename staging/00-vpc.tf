resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_subnet_prefix}.0.0/16"

  tags = {
    Name        = "${var.app_name}-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "vpc_sub_app1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "${var.vpc_subnet_prefix}.1.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name        = "${var.app_name}-app-1a"
    Environment = var.environment
  }
}

resource "aws_subnet" "vpc_sub_app2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "${var.vpc_subnet_prefix}.2.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    Name        = "${var.app_name}-app-1b"
    Environment = var.environment
  }
}

resource "aws_subnet" "vpc_sub_db1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "${var.vpc_subnet_prefix}.10.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name        = "${var.app_name}-db-1a"
    Environment = var.environment
  }
}

resource "aws_subnet" "vpc_sub_db2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "${var.vpc_subnet_prefix}.11.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    Name        = "${var.app_name}-db-1b"
    Environment = var.environment
  }
}

resource "aws_subnet" "vpc_sub_web1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "${var.vpc_subnet_prefix}.20.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name        = "${var.app_name}-web-1a"
    Environment = var.environment
  }
}

resource "aws_subnet" "vpc_sub_web2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "${var.vpc_subnet_prefix}.21.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    Name        = "${var.app_name}-web-1b"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.app_name}-ig"
    Environment = var.environment
  }
}

resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name        = "${var.app_name}-rtb"
    Environment = var.environment
  }
}