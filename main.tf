module "mini_eks" {
     source = "./modules/vpc"
     environment = var.common_variables["environment"]
     project_name = var.common_variables["project_name"]
     common_tags = var.common_variables["common_tags"]
     vpc_cidr_block = var.vpc["vpc_cidr_block"]

     azs = var.vpc["azs"]
     public_subnet_cidr = var.vpc["public_subnet_cidr"]
     private_subnet_cidr = var.vpc ["private_subnet_cidr"]
     db_subnet_cidr = var.vpc["db_subnet_cidr"]
     enable_nat = var.vpc["enable_nat"]
}

