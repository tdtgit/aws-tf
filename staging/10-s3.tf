resource "aws_s3_bucket" "tf-app" {
  bucket = "for-${lower(var.app_name)}-app"
  acl    = "private"

  tags = {
    Name        = "For ${var.app_name} App"
    Environment = "Dev"
  }
}