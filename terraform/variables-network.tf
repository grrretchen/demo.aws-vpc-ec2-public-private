# CIDR Block for VPC
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

# CIDR Block for Public Subnet
variable "subnet1_cidr_public" {
  type = string
  default = "10.0.1.0/24"
}

# CIDR Block for Private Subnet
variable "subnet1_cidr_private" {
  type = string
  default = "10.0.2.0/24"
}

# CIDR Block for Public Subnet
variable "subnet1_zone_public" {
  type = string
  default = "a"
}

# CIDR Block for Private Subnet
variable "subnet1_zone_private" {
  type = string
  default = "b"
}
