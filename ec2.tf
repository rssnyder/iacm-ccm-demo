resource "aws_instance" "idle" {
  ami                    = var.ami
  instance_type          = "m7g.xlarge"
  iam_instance_profile   = var.ssm_instance_profile
  user_data              = <<EOF
#!/bin/bash
sudo apt-get update -y &&
sudo apt-get install -y nginx
EOF
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  tags = {
    Name = "${var.name}-idle"
  }
}

resource "aws_instance" "half" {
  ami                    = var.ami
  instance_type          = "m7g.xlarge"
  iam_instance_profile   = var.ssm_instance_profile
  user_data              = <<EOF
#!/bin/bash
sudo apt-get update -y &&
sudo apt-get install -y nginx stress
stress --cpu 1
EOF
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  tags = {
    Name = "${var.name}-half"
  }
}

resource "aws_instance" "full" {
  ami                    = var.ami
  instance_type          = "m7g.xlarge"
  iam_instance_profile   = var.ssm_instance_profile
  user_data              = <<EOF
#!/bin/bash
sudo apt-get update -y &&
sudo apt-get install -y nginx stress
stress --cpu 2 &
EOF
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  tags = {
    Name = "${var.name}-full"
  }
}

resource "aws_security_group" "allow_http" {
  name        = "${var.name}-instance-allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc

  ingress {
    description = "Open HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Open SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.name}-allow_http"
  }
}