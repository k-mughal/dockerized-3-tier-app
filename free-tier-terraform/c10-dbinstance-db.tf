########### MySql  ##################

resource "aws_db_instance" "maindb" {
  identifier              = "mydb-instance"
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0.35"
  instance_class          = "db.m5.large"
  storage_type            = "gp3"
  db_name                 = "mydb"
  username                = "admin123"         #local.db_creds.username
  password                = "mypass123456*"    #local.db_creds.password
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.db-sg.id]
  parameter_group_name    = "default.mysql8.0"
  skip_final_snapshot     = true
  publicly_accessible     = true
}

########### PostgreSQL##################
/*
resource "aws_db_instance" "maindb" {
  identifier              = "mydb-instance"
  allocated_storage       =  20
  engine                  = "postgres"
  engine_version          = "15.4"
  instance_class          = "db.m5.large"
  storage_type            = "gp3"
  db_name                 = "mydb"
  username                =  "admin123"         #local.db_creds.username
  password                =  "mypass123456*"    #local.db_creds.password
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.db-sg.id]
  parameter_group_name    = "default.postgres15"
  skip_final_snapshot     = true
  publicly_accessible     = true
}

*/