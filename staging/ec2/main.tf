resource "aws_instance" "tf_ec2_app1" {
  ami           = "ami-00b8d9cb8a7161e41"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.tf_vpc_sub_a1.id

  tags = {
    Name = "TF-App1"
  }
}

resource "aws_instance" "tf_ec2_app2" {
  ami           = "ami-00b8d9cb8a7161e41"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.tf_vpc_sub_a2.id

  tags = {
    Name = "TF-App2"
  }
}