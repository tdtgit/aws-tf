resource "aws_vpc" "main_vpc" {
  cidr_block = "${var.vpc_subnet_prefix}.0.0/16"

  tags = {
    Name        = "${var.app_name}-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "app_1a" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "${var.vpc_subnet_prefix}.1.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name        = "${var.app_name}-app-sub-1a"
    Environment = var.environment
  }
}

resource "aws_subnet" "app_1b" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "${var.vpc_subnet_prefix}.2.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    Name        = "${var.app_name}-app-sub-1b"
    Environment = var.environment
  }
}

resource "aws_subnet" "db_1a" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "${var.vpc_subnet_prefix}.10.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name        = "${var.app_name}-db-sub-1a"
    Environment = var.environment
  }
}

resource "aws_subnet" "db_1b" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "${var.vpc_subnet_prefix}.11.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    Name        = "${var.app_name}-db-sub-1b"
    Environment = var.environment
  }
}

resource "aws_subnet" "web_1a" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "${var.vpc_subnet_prefix}.20.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name        = "${var.app_name}-web-sub-1a"
    Environment = var.environment
  }
}

resource "aws_subnet" "web_1b" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "${var.vpc_subnet_prefix}.21.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    Name        = "${var.app_name}-web-sub-1b"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name        = "${var.app_name}-igw"
    Environment = var.environment
  }
}

resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.main_vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${var.app_name}-rtb"
    Environment = var.environment
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main_vpc.id

}

resource "aws_route_table_association" "private_subnet_db_1a" {
  subnet_id      = aws_subnet.db_1a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_subnet_db_1b" {
  subnet_id      = aws_subnet.db_1b.id
  route_table_id = aws_route_table.private.id
}