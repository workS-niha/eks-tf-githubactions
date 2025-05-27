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