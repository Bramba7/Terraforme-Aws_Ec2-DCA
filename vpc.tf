resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name        = "VPC_${var.env}"
    Environment = var.env
    Provisioner = "Terraform"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "IGW_${var.env}"
    Environment = var.env
    Provisioner = "Terraform"
  }
}

### Subnets
resource "aws_subnet" "public_subnet1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_sub_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name        = "Public_Subnet_1_${var.env}"
    Environment = var.env
    Provisioner = "Terraform"
  }
}

### Tables
resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name        = "rtb_public_${var.env}"
    Environment = var.env
    Provisioner = "Terraform"
  }
}

resource "aws_route_table_association" "rtba_public1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.rtb_public.id
}

### Security Grups
#####################                       Disclaimer                         #######################
#### This SG setup is for academic purposes only, and should never be reproducible in production. ####
######################################################################################################
resource "aws_security_group" "sg-ec2" {
  name        = "sg_for_ec2"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "all UDP"
    from_port   = 0
    to_port     = 65500
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "all TCP"
    from_port   = 0
    to_port     = 65500
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "all"
    from_port   = 8
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "sg_for_EC2"
    Environment = var.env
    Provisioner = "Terraform"
  }
}
