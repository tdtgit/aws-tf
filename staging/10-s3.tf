resource "aws_s3_bucket" "tf-s3" {
  bucket        = "for-${lower(var.app_name)}-app"
  acl           = "private"
  force_destroy = true

  tags = {
    name        = "For ${var.app_name} ELB Logging"
    environment = var.environment
  }
}

resource "aws_s3_bucket_policy" "tf-s3-policy" {
  bucket = aws_s3_bucket.tf-s3.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_elb_service_account.main.id}:root"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.tf-s3.bucket}/${var.s3_prefix}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.tf-s3.bucket}/${var.s3_prefix}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.tf-s3.bucket}"
    }
  ]
}
POLICY
}