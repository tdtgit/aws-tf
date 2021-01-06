variable "app_name" {
  type    = string
  default = "DAT"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "ec2_app_size" {
  type    = string
  default = "t2.nano"
}

variable "ec2_db_size" {
  type    = string
  default = "t2.nano"
}

variable "s3_prefix" {
  type    = string
  default = "LB"
}