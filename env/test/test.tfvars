aws_region = "us-east-1"
common_variables = {
    environment = "test"
    project_name = "youva"
    common_tags = {
        "Project" = "youva"
        "Environment" = "Test"
        "ManagedBy" = "Terraform"
        "Owner" = "Niha"
    }
}

vpc = {
    vpc_cidr_block = "10.0.0.0/16"
    azs = ["us-east-1a" ,"us-east-1b"]
    public_subnet_cidr = ["10.0.1.0/24" , "10.0.2.0/24"]
    private_subnet_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
    db_subnet_cidr = ["10.0.5.0/24", "10.0.6.0/24"]
    enable_nat = true
}