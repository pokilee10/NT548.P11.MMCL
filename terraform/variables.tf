variable "region" {
  description = "AWS region"
  type        = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default = [ "10.0.1.0/24" ]

}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default = [ "10.0.2.0/24" ]
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default = [ "us-east-1a", "us-east-1b" ]
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default = "ami-0866a3c8686eaeeba"
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  type        = string
  default = "t2.micro"
}

variable "public_instance_count" {
  description = "Number of public EC2 instances"
  type        = number
  default = 1
}

variable "private_instance_count" {
  description = "Number of private EC2 instances"
  type        = number
  default = 1
}

variable "my_ip" {
  description = "Your IP address"
  type        = string
}

variable "id_ed25519_pub" {
  description = "Public key for SSH access"
  type        = string
}

variable "key_name" {
  description = "Public key for SSH access"
  type        = string
  default = "lxlso1"
}