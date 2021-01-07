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

variable "sizing" {
  type = object({
    ec2_app = string
    ec2_web = string
    rds_master = string
    rds_read = string
  })
  default = {
    ec2_app = "t2.nano"
    ec2_web = "t2.nano"
    rds_master = "t2.micro"
    rds_read = "t2.micro"
  }
}

variable "elb_log_prefix" {
  type = object({
    public = string
    private = string
  })
  default = {
    public = "PublicLBLogs"
    private = "PrivateLBLogs"
  }
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