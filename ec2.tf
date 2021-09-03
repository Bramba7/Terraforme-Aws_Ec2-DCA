
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "ec2" {
  count                       = var.instance_replica
  associate_public_ip_address = true
  ami                         = data.aws_ami.ubuntu.id
  subnet_id                   = aws_subnet.public_subnet1.id
  private_ip                  = cidrhost(var.public_sub_cidr, count.index + 10)
  vpc_security_group_ids      = [aws_security_group.sg-ec2.id]
  instance_type               = var.instance_type
  key_name                    = var.ssh-key
  user_data                   = templatefile("user_data.tftpl", { num = var.instance_replica, machine = count.index })

  tags = {
    Name        = "Docker-node-${count.index + 1}"
    Environment = var.env
    Provisioner = "Terraform"
  }
}

