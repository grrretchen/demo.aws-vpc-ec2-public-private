# VPC
resource "aws_vpc" "main" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = merge(
    module.tags.tags, {
      Name = format("%s-%s", var.project_name, "vpc")
    }
  )
}


# VPC Subnet
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "${var.subnet1_cidr_public}"
  availability_zone = "${var.aws_region}${var.subnet1_zone_public}"
  map_public_ip_on_launch = true

  tags = merge(
    module.tags.tags, {
      Name = format("%s-%s", var.project_name, "public")
    }
  )
}

# VPC Subnet
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "${var.subnet1_cidr_private}"
  availability_zone = "${var.aws_region}${var.subnet1_zone_private}"
  map_public_ip_on_launch = false

  tags = merge(
    module.tags.tags, {
      Name = format("%s-%s", var.project_name, "private")
    }
  )
}

# VPC Internet Gateway
resource "aws_internet_gateway" "main" {
  tags = merge(
    module.tags.tags, {
      Name = format("%s-%s", var.project_name, "gateway")
    }
  )
}


# VPC Internet Gateway Attachment
resource "aws_internet_gateway_attachment" "main" {
  internet_gateway_id = aws_internet_gateway.main.id
  vpc_id              = aws_vpc.main.id
}