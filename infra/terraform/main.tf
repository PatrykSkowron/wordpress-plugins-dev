provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}


resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = var.deployer_public_key
}

resource "aws_instance" "wordpress_app" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  security_groups = [aws_security_group.allow_http.name,aws_security_group.ssh_dev.name]
  key_name = aws_key_pair.deployer.key_name

  user_data = "../../package.zip"

  provisioner "file" {
    source      = "../../package.zip"
    destination = "/tmp/package.zip"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +r /tmp/package.zip",
      "unzip /tmp/package.zip -d /tmp/package",
      "cd /tmp/package",
      "make run",
    ]
  }

  tags = {
    Name = var.tag
  }


}

resource "aws_security_group" "allow_http" {
  name        = "allow_htpp"
  description = "Allow HTTP inbound traffic"

  ingress {
//    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  tags = {
    Name = var.tag
  }
}


resource "aws_security_group" "ssh_dev" {
  name        = "ssh_dev"
  description = "Allow SSH from deployer"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ips
  }

  tags = {
    Name = var.tag
  }
}