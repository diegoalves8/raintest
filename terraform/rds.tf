resource "aws_db_instance" "rainusdb" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  name                 = "microapi"
  username             = "root"
  password             = "vander123"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  subnet_ids = [aws_subnet.sub1-rain.id]
}
output endpoint {
    value = aws_db_instance.rainusdb.address
}
