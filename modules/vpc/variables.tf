variable "env" {
  description = "The environment for the VPC (e.g., dev, prod)"
  type        = string

}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "A list of availability zones"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks for private subnets"
  type        = list(string)
}

variable "private_db_subnet_cidrs" {
  description = "A list of CIDR blocks for private database subnets"
  type        = list(string)
}
