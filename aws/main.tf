provider "aws" {
  region = "eu-central-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "sample_server" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.ubuntu.id
  vpc_security_group_ids = ["sg-0943ad0b8875a7e25"]

  tags = {
    "Name" = "akeron_sample_server"
  }
}

output "sample_server_dns" {
  value = aws_instance.sample_server.public_dns
}
