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
}