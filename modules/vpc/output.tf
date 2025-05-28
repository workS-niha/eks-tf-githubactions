output "vpc_id" {
    description = "the id of the vpc"
    value = aws_vpc.ghac.id
  
}

 output "pubids" { 
   description = "public subnet ids"
   value = aws_subnet.pub[*].id
 }


output "pvtids" { 
   description = "private subnet ids"
   value = aws_subnet.pvt[*].id
 }


 output "dbids" {
   description = "db subnet ids"
   value = aws_subnet.db[*].id
 }


output "aws_eip" {
  description = "aws elastic ip"
  value = aws_eip.cost.id
}

