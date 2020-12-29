variable "app_name" {
  type    = string
  default = "DAT"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "ec2_app_size" {
  type    = string
  default = "t2.nano"
}

variable "ec2_db_size" {
  type    = string
  default = "t2.nano"
}