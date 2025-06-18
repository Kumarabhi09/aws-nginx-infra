output "web_public_ip" {
  value = aws_instance.web.public_ip
}

output "web_public_dns" {
  value = aws_instance.web.public_dns
}
