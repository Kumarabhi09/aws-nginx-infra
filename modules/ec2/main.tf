resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.web_sg_id]
  key_name               = var.key_name

  user_data = <<-EOF
  #!/bin/bash
  set -e
  # For Amazon Linux 2 (yum) OR Amazon Linux 2023 (dnf)
  if command -v yum >/dev/null 2>&1; then
   yum update -y
   yum install -y nginx || amazon-linux-extras install -y nginx1
  elif command -v dnf >/dev/null 2>&1; then
    dnf update -y
    dnf install -y nginx
  fi
  systemctl enable nginx
  systemctl start nginx
  EOF


  tags = {
    Name = "WebServer"
  }
}
