
# App
resource "aws_instance" "app_ec2" {
  count         = 2
  ami           = data.aws_ami.app_ami.id
  instance_type = var.sizing.app_ec2
  subnet_id     = aws_subnet.app_1a.id
  key_name      = aws_key_pair.ssh.key_name
  security_groups = [
    aws_security_group.app_sg.id
  ]

  tags = {
    Name        = "${var.app_name}_app_${count.index + 1}"
    Environment = var.environment
  }
}

# Web
resource "aws_instance" "web_ec2" {
  count         = 2
  ami           = data.aws_ami.app_ami.id
  instance_type = var.sizing.web_ec2
  subnet_id     = aws_subnet.web_1a.id
  key_name      = aws_key_pair.ssh.key_name
  security_groups = [
    aws_security_group.web_sg.id
  ]

  tags = {
    Name        = "${var.app_name}_web_${count.index + 1}"
    Environment = var.environment
  }
}