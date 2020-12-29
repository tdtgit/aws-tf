resource "aws_instance" "tf_ec2_app1" {
  ami           = "ami-0c20b8b385217763f"
  instance_type = var.ec2_app_size
  subnet_id = aws_subnet.tf_vpc_sub_a1.id
  key_name = aws_key_pair.SSH.key_name
  security_groups = [ aws_security_group.app_sg.id ]

  tags = {
    Name = "${var.app_name}-App1"
    Environment = var.environment
  }
}

resource "aws_instance" "tf_ec2_app2" {
  ami           = "ami-0c20b8b385217763f"
  instance_type = var.ec2_app_size
  subnet_id = aws_subnet.tf_vpc_sub_a2.id
  key_name = aws_key_pair.SSH.key_name
  security_groups = [ aws_security_group.app_sg.id ]

  tags = {
    Name = "${var.app_name}-App2"
    Environment = var.environment
  }
}

resource "aws_eip" "app2" {
  instance = aws_instance.tf_ec2_app2.id
  vpc      = true
}

resource "aws_eip" "app1" {
  instance = aws_instance.tf_ec2_app1.id
  vpc      = true
}