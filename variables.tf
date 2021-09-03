variable "region" {
  description = "Define what region the instance will be deployed"
  default     = "us-east-1"
}


### EC2
variable "name" {
  description = "Instance's name"
  default     = "node"
}

variable "env" {
  description = "Application's Enviroment"
  default     = "dev-study"
}

variable "instance_type" {
  description = "AWS Instance type defines the hardware configuration of the machine"
  default     = "t2.micro"
}

variable "ssh-key" {
  description = "Name of ssh key"
  default     = "Docker_key"

}
variable "instance_replica" {
  description = "Number of instance"
  default     = 4
}


### VPC
variable "vpc_cidr" {
  description = "VPC cidr block."
  default     = "20.0.0.0/16"
}
variable "public_sub_cidr" {
  description = "subnet cidr block."
  default     = "20.0.1.0/24"
}
