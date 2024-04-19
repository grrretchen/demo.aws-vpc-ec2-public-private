# EC2 Key Pair
data "local_file" "sshkey" {
  filename = "${path.module}/id_ssh.pub"
}

resource "aws_key_pair" "keypair" {
  key_name_prefix = format("%s-", var.project_name)
  public_key      = data.local_file.sshkey.content

  tags = merge(
    module.tags.tags,
    {}
  )
}

# my public IP
data "external" "myipaddr" {
  program = ["bash", "-c", "curl -s 'https://ipinfo.io/json'"]
}

# VPC Security Group
resource "aws_security_group" "public" {
  vpc_id = aws_vpc.main.id

  # Inbound Rules
  # SSH access from same network
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.external.myipaddr.result.ip}/32"]
  }

  # Outbound Rules
  # Internet access to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    module.tags.tags, {
      Name = format("%s-%s", var.project_name, "public")
    }
  )
}

# VPC Security Group
resource "aws_security_group" "private" {
  vpc_id = aws_vpc.main.id

  # Inbound Rules
  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  # Outbound Rules
  # Internet access to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    module.tags.tags, {
      Name = format("%s-%s", var.project_name, "private")
    }
  )
}