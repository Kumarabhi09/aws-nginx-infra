output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "web_sg_id" {
  value = aws_security_group.web.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}
