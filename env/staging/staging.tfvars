aws_region = "ap-south-1"
common_variables = {
    environment = "stage"
    project_name = "prime"
    common_tags = {
        "Project" = "prime"
        "Environment" = "stage"
        "ManagedBy" = "Terraform"
        "Owner" = "mini"
    }
}

vpc = {
    vpc_cidr_block = "172.0.0.0/16"
}