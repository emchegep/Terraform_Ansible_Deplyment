variable "instance_type" {
  type        = string                     # The type of the variable, in this case a string
  default     = "t2.micro"                 # Default value for the variable
  description = "The type of EC2 instance" # Description of what this variable represents
}

variable "ami" {
  type        = string
  default     = "ami-0f5fcdfbd140e4ab7"
  description = "The AMI to use for the EC2 instance"
}

variable "aws_region" {
  type        = string
  default     = "us-east-2"
  description = "The AWS region to use"
}