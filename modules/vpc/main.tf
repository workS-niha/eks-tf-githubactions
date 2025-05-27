locals {
   name = "${var.environment}-${var.project_name}"
}

resource "aws_vpc" "ghac" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true


  tags = merge(
   { 
    Name = "${local.name}-vpc"
    },
    var.common_tags
  )
}