# App
resource "aws_instance" "tf_ec2_app1" {
  ami             = data.aws_ami.ubuntu2004lts.id
  instance_type   = var.sizing.ec2_app
  subnet_id       = aws_subnet.tf_vpc_sub_a1.id
  key_name        = aws_key_pair.SSH.key_name
  security_groups = [
    aws_security_group.tf-app-sg.id
  ]

  tags = {
    Name        = "${var.app_name}-App1"
    Environment = var.environment
  }
}

resource "aws_eip" "app1" {
  instance = aws_instance.tf_ec2_app1.id
  vpc      = true

  tags = {
    Name        = "${var.app_name}-EIP-App1"
    Environment = var.environment
  }
}

resource "aws_instance" "tf_ec2_app2" {
  ami             = data.aws_ami.ubuntu2004lts.id
  instance_type   = var.sizing.ec2_app
  subnet_id       = aws_subnet.tf_vpc_sub_a2.id
  key_name        = aws_key_pair.SSH.key_name
  security_groups = [
    aws_security_group.tf-app-sg.id
  ]

  tags = {
    Name        = "${var.app_name}-App2"
    Environment = var.environment
  }
}

resource "aws_eip" "app2" {
  instance = aws_instance.tf_ec2_app2.id
  vpc      = true

  tags = {
    Name        = "${var.app_name}-EIP-App1"
    Environment = var.environment
  }
}

# Web
resource "aws_instance" "tf_ec2_web1" {
  ami             = data.aws_ami.ubuntu2004lts.id
  instance_type   = var.sizing.ec2_web
  subnet_id       = aws_subnet.tf_vpc_sub_c1.id
  key_name        = aws_key_pair.SSH.key_name
  security_groups = [
    aws_security_group.tf-web-sg.id
  ]

  tags = {
    Name        = "${var.app_name}-Web1"
    Environment = var.environment
  }
}

resource "aws_eip" "web1" {
  instance = aws_instance.tf_ec2_web1.id
  vpc      = true

  tags = {
    Name        = "${var.app_name}-EIP-Web1"
    Environment = var.environment
  }
}

resource "aws_instance" "tf_ec2_web2" {
  ami             = data.aws_ami.ubuntu2004lts.id
  instance_type   = var.sizing.ec2_web
  subnet_id       = aws_subnet.tf_vpc_sub_c2.id
  key_name        = aws_key_pair.SSH.key_name
  security_groups = [
    aws_security_group.tf-web-sg.id
  ]

  tags = {
    Name        = "${var.app_name}-Web2"
    Environment = var.environment
  }
}

resource "aws_eip" "web2" {
  instance = aws_instance.tf_ec2_web2.id
  vpc      = true

  tags = {
    Name        = "${var.app_name}-EIP-Web2"
    Environment = var.environment
  }
}