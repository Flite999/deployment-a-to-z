provider "aws" {
  region = "us-east-1"
}

module "rds" {
  source = "./modules/rds"
}

module "fargate" {
  source = "./modules/fargate"
}

module "route53" {
  source = "./modules/route53"
}

module "sns" {
  source = "./modules/sns"
}