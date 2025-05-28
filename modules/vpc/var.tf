variable "vpc_cidr_block" {
    description = "vpc cidr block value"
    type = string
}

variable "project_name" {
  description = "project name"
  type = string
}

variable "environment" {
    description = "name of the environment vpc"
    type = string 
}

variable "common_tags" { 
    description = "common tags for all resources"
    type = map(string)
    default = {}
}

variable "public_subnet_cidr" {
  description = "cidr range for public subnets"
  type = list(string) 
}

variable "azs" {
    description = "availability zone for subnet"
    type = list(string)
}

variable "private_subnet_cidr" {
  description = "cidr range for private subnets"
  type = list(string) 
}

variable "db_subnet_cidr" {
  description = "cidr range for db subnets"
  type = list(string) 
}


variable "enable_nat" {
  description = "to enable nat gateway"
  type = bool
}