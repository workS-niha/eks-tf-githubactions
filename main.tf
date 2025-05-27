module "mini_eks" {
     source = "./modules/vpc"
     environment = var.common_variables["environment"]
     project_name = var.common_variables["project_name"]
     common_tags = var.common_variables["common_tags"]
     vpc_cidr_block = var.common_variables["vpc_cidr_block"]
     
 
}