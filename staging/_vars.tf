variable "app_name" {
  type    = string
  default = "DAT"
}

variable "environment" {
  type    = string
  default = "development"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "ec2_app_size" {
  type    = string
  default = "t2.nano"
}

variable "rds_db_size" {
  type    = string
  default = "t2.micro"
}

variable "lb_public_s3_prefix" {
  type    = string
  default = "PublicLBLogs"
}

variable "lb_private_s3_prefix" {
  type    = string
  default = "PrivateLBLogs"
}

variable "vpc_subnet_prefix" {
  type    = string
  # Or 10.0 or 10.100 or whatever you want
  default = "172.29"
}

variable "rds_config" {
  type = object({
    username = string
    password = string
    database = string
  })
  default = {
    username = "db_user"
    password = "db_password"
    database = "db"
  }
}

resource "random_string" "rand_db_name" {
  length = 8
  special = false
}