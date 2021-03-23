resource "aws_db_instance" "rainusdb" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  name                 = "microapi"
  username             = "root"
  password             = "vander123"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  #db_subnet_group_name = aws_db_subnet_group.rdsrain
  vpc_security_group_ids = ["rds-sg"]
}
output endpoint {
    value = aws_db_instance.rainusdb.address
}

#resource "aws_db_subnet_group" "rdsrain" {
#  name       = "rdsrain"
#  subnet_ids = [aws_subnet.private]
#
#  tags = {
#    Name = "My DB subnet group"
#  }
#}