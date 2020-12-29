resource "aws_s3_bucket" "tf-app" {
  bucket = "for-${lower(var.app_name)}-app"
  acl    = "private"

  tags = {
    Name        = "S3 storage ${var.app_name} App"
    Environment = "Dev"
  }
}