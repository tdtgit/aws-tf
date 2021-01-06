resource "aws_instance" "tf_ec2_app1" {
  ami           = data.aws_ami.ubuntu2004lts.id
  instance_type = var.ec2_app_size
  subnet_id = aws_subnet.tf_vpc_sub_a1.id
  key_name = aws_key_pair.SSH.key_name
  security_groups = [aws_security_group.tf-app-sg.id]

  tags = {
    name = "${var.app_name}-App1"
    environment = "Dev"
  }
}

resource "aws_eip" "app1" {
  instance = aws_instance.tf_ec2_app1.id
  vpc      = true

  tags = {
    name = "${var.app_name}-EIP-App1"
    environment = "Dev"
  }
}

resource "aws_instance" "tf_ec2_app2" {
  ami           = data.aws_ami.ubuntu2004lts.id
  instance_type = var.ec2_app_size
  subnet_id = aws_subnet.tf_vpc_sub_a2.id
  key_name = aws_key_pair.SSH.key_name
  security_groups = [aws_security_group.tf-app-sg.id]

  tags = {
    name = "${var.app_name}-App2"
    environment = "Dev"
  }
}

resource "aws_eip" "app2" {
  instance = aws_instance.tf_ec2_app2.id
  vpc      = true

  tags = {
    name = "${var.app_name}-EIP-App1"
    environment = "Dev"
  }
}