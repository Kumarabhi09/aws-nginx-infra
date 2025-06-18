terraform {
  required_version = ">= 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.100.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "network" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "compute" {
  source           = "./modules/ec2"
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  key_name         = var.key_name
  public_subnet_id = module.network.public_subnet_id
  web_sg_id        = module.network.web_sg_id
}

output "ec2_public_ip" {
  description = "Public IPv4 address of the web server"
  value       = module.compute.web_public_ip
}

output "ec2_public_dns" {
  description = "Public DNS of the web server"
  value       = module.compute.web_public_dns
}

output "public_subnet_id" {
  value = module.network.public_subnet_id
}

output "web_sg_id" {
  value = module.network.web_sg_id
}
