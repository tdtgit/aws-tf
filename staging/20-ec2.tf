# App
resource "aws_instance" "tf_ec2_app" {
  count           = 4
  ami             = "ami-0dffcf3c26d79e0bb"
  instance_type   = var.sizing.ec2_app
  subnet_id       = aws_subnet.tf_vpc_sub_a1.id
  key_name        = aws_key_pair.SSH.key_name
  security_groups = [
    aws_security_group.tf-app-sg.id
  ]

  tags = {
    Name        = "${var.app_name}-App-${count.index + 1}"
    Environment = var.environment
  }
}

# Web
resource "aws_instance" "tf_ec2_web" {
  count           = 4
  ami             = "ami-0dffcf3c26d79e0bb"
  instance_type   = var.sizing.ec2_web
  subnet_id       = aws_subnet.tf_vpc_sub_c1.id
  key_name        = aws_key_pair.SSH.key_name
  security_groups = [
    aws_security_group.tf-web-sg.id
  ]

  tags = {
    Name        = "${var.app_name}-Web-${count.index + 1}"
    Environment = var.environment
  }
}