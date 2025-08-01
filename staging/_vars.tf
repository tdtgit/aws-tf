variable "app_name" {
  type    = string
  default = "myproject"
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
    app_ec2    = string
    web_ec2    = string
    rds_master = string
    rds_read   = string
  })
  default = {
    app_ec2    = "t4g.nano"
    web_ec2    = "t4g.nano"
    rds_master = "t4g.micro"
    rds_read   = "t4g.micro"
  }
}

variable "elb_log_prefix" {
  type = object({
    public  = string
    private = string
  })
  default = {
    public  = "PublicLBLogs"
    private = "PrivateLBLogs"
  }
}

variable "vpc_subnet_prefix" {
  type = string
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
  length  = 8
  special = false
}