resource "aws_db_instance" "db" {
  allocated_storage      = 20
  storage_type           = "gp3"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.${var.sizing.rds_master}"
  identifier             = "${lower(var.app_name)}-${lower(var.rds_config.database)}-${lower(random_string.rand_db_name.result)}"
  username               = var.rds_config.username
  password               = var.rds_config.password
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${lower(var.app_name)}_db_subnet_group"
  subnet_ids = [aws_subnet.db_1a.id, aws_subnet.db_1b.id]

  tags = {
    Environment = var.environment
  }
}