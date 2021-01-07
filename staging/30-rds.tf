resource "aws_db_instance" "tf_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.${var.sizing.rds_master}"
  identifier           = "${lower(var.app_name)}-${lower(var.rds_config.database)}-${lower(random_string.rand_db_name.result)}"
  name                 = var.rds_config.database
  username             = var.rds_config.username
  password             = var.rds_config.password
  parameter_group_name = "default.mysql5.7"

  skip_final_snapshot = true

  vpc_security_group_ids = [aws_security_group.tf-db-sg.id]
  db_subnet_group_name = aws_db_subnet_group.tf_db_subnet.name
}

resource "aws_db_subnet_group" "tf_db_subnet" {
  name       = "${lower(var.app_name)}-subnet-db"
  subnet_ids = [aws_subnet.tf_vpc_sub_b1.id, aws_subnet.tf_vpc_sub_b2.id]

  tags = {
    Environment = var.environment
  }
}