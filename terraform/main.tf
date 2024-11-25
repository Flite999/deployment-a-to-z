provider "aws" {
  region = "us-east-1"
}

module "rds" {
  source      = "./modules/rds"
  db_username = var.db_username
  db_password = var.db_password
}

module "fargate" {
  source          = "./modules/fargate"
  security_groups = ["sg-074dccb6e53d84934"]
  subnets         = ["subnet-0cb91e2ba609fa499", "subnet-03fd53ca984362ebd"]
}

module "route53" {
  source = "./modules/route53"
}

module "sns" {
  source = "./modules/sns"
}