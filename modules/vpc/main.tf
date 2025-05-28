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

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ghac.id

   tags = merge(
   { 
    Name = "${local.name}-igw"
    },
    var.common_tags
  )
}


resource "aws_subnet" "pub" {
  count = length(var.public_subnet_cidr) 
  vpc_id     = aws_vpc.ghac.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = merge(
   { 
    Name = "${local.name}-pubsub-${split("-",var.azs[count.index])[2]}"
    },
    var.common_tags
  )
}


resource "aws_subnet" "pvt" {
  count = length(var.private_subnet_cidr) 
  vpc_id     = aws_vpc.ghac.id
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
   { 
    Name = "${local.name}-pvtsub-${split("-",var.azs[count.index])[2]}"
    },
    var.common_tags
  )
}


resource "aws_subnet" "db" {
  count = length(var.db_subnet_cidr) 
  vpc_id     = aws_vpc.ghac.id
  cidr_block = var.db_subnet_cidr[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
   { 
    Name = "${local.name}-dbsub-${split("-",var.azs[count.index])[2]}"
    },
    var.common_tags
  )
}



resource "aws_route_table" "route-pub" {
  vpc_id = aws_vpc.ghac.id

  tags = merge(
   { 
    Name = "${local.name}-pubroute"
   },
   var.common_tags
  )
}


resource "aws_route_table" "route-pvt" {
  vpc_id = aws_vpc.ghac.id
  
  tags = merge(
   { 
    Name = "${local.name}-pvtroute"
   },
   var.common_tags
  )
}

resource "aws_route_table" "route-db" {
  vpc_id = aws_vpc.ghac.id

  tags = merge(
   { 
    Name = "${local.name}-dbroute"
   },
   var.common_tags
  )
}

resource "aws_route_table_association" "pub-rt-a" {
  count = length(aws_subnet.pub)
  subnet_id      = aws_subnet.pub[count.index].id
  route_table_id = aws_route_table.route-pub.id
} 

resource "aws_route_table_association" "pvt-rt-a" {
  count = length(aws_subnet.pvt)
  subnet_id      = aws_subnet.pvt[count.index].id
  route_table_id = aws_route_table.route-pvt.id
} 

resource "aws_route_table_association" "db-rt-a" {
  count = length(aws_subnet.db)
  subnet_id      = aws_subnet.db[count.index].id
  route_table_id = aws_route_table.route-db.id
} 


resource "aws_eip" "cost" {
  count = var.enable_nat ? 1 : 0   
  domain   = "vpc"
}

resource "aws_nat_gateway" "my_nat" {
  count = var.enable_nat ? 1 : 0
  allocation_id = aws_eip.cost[count.index].id
  subnet_id     = aws_subnet.pub[0].id

   tags = merge(
   { 
    Name = "${local.name}-ngw"
   },
   var.common_tags
  )
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route" "pub_internet" {
  route_table_id            = aws_route_table.route-pub.id
  gateway_id = aws_internet_gateway.igw.id
  destination_cidr_block   = "0.0.0.0/0"
}


resource "aws_route" "pvt-nat" {
  route_table_id            = aws_route_table.route-pvt.id
  nat_gateway_id = aws_nat_gateway.my_nat[0].id
  destination_cidr_block   = "0.0.0.0/0"
}

resource "aws_route" "db-nat" {
  route_table_id            = aws_route_table.route-db.id
  nat_gateway_id = aws_nat_gateway.my_nat[0].id
  destination_cidr_block   = "0.0.0.0/0"
}