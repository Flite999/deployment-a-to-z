resource "aws_db_instance" "default" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "14.15"
  instance_class       = "db.t2.micro"
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.postgres14"
  skip_final_snapshot  = true
}

variable "db_name" {
  default = "a_to_z_deployment"
}

variable "db_username" {
  description = "The username for the RDS instance"
}

variable "db_password" {
  description = "The password for the RDS instance"
}

output "db_endpoint" {
  value = aws_db_instance.default.endpoint
}