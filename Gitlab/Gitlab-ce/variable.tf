variable "region" {
  type        = string
  description = "the AWS region in which resources are created"
}

variable "access_key" {
  type        = string
  description = "aws access key account"
}

variable "secret_key" {
  type        = string
  description = "aws access key account"
}

variable "instance_type" {
  type        = string
  description = " ec2 instance type that gitlab is running on it"
}

variable "ami" {
  type        = string
  description = "ami of ec2 instance"
}

variable "public_key" {
  type        = string
  description = " public key for generating key pair "
}