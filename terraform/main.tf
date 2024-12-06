terraform {
  backend "s3" {
    bucket         = "flite-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}


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
  vpc_id          = "vpc-03d82abc5f8322f6a"
}

# module "route53" {
#   source = "./modules/route53"
# }

module "sns" {
  source = "./modules/sns"
}

output "backend_record" {
  value = module.fargate.backend_dns_name
}

output "db_endpoint" {
  value = module.rds.db_endpoint
}
