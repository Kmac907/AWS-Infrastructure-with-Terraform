provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source = "./vpc.tf"
}

module "security_groups" {
  source = "./security_groups.tf"
}

module "ec2" {
  source = "./ec2.tf"
}

module "rds" {
  source = "./rds.tf"
}

module "monitoring" {
  source = "./monitoring.tf"
}
