# AWS Terraform Templates (boilerplate)
This project is my first Terraform project, please contribute if you see any issues or got new ideas.

### 🚀 What you will get
- [x] 4 EC2 instances (2 for web, 2 for app)
- [x] 1 RDS instance
- [x] 2 public/private ALB with access logs to S3 bucket

All of the above come with auto created VPC with 3 subnets for web, app, and database (3-tier architecture), secured and ready-to-use security groups.

### 🔖 How to use it
1. Create a secret file named `/.secret/staging_keys` or `/.secret/production_keys` with AWS access key information:
```
[default]
aws_access_key_id=AKRAGAUMSDNTAWOWMKIQ
aws_secret_access_key=d6Uz8w9JD/+G2kgoxsZK6n21wdznE/XGYkUeB3E/
```
2. `cd` to the environment folder `staging` or `production`.
2. Customize project's variables in `_vars.tf` file.
2. Run `terraform init` then `terraform apply` to deploy.
2. Profit.

### ⚡️ Coming soon
- [ ] Autoscaling group
- [ ] ElastiCache instances
- [ ] CloudFront CDN
- [ ] Master/slave databases