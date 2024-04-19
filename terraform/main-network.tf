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

  tags = merge(
    module.tags.tags, {
      Name = format("%s-%s", var.project_name, "private")
    }
  )
}