# KEYPAIRS --------------------------------------------------------------------
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


# EXTERNAL LOOKUP for MY PUBLIC IP --------------------------------------------
# my public IP
data "external" "myipaddr" {
  program = ["bash", "-c", "curl -s 'https://ipinfo.io/json'"]
}


# SECURITY GROUPS -------------------------------------------------------------

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
      Name = format("%s-sg-%s", var.project_name, "public")
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
      Name = format("%s-sg-%s", var.project_name, "private")
    }
  )
}

# COMPUTE userdata -------------------------------------------------------------
# EC2 User Data
data "local_file" "userdata" {
  filename = "${path.module}/userdata.txt"
}


# COMPUTE NODES ----------------------------------------------------------------
# PUBLIC
resource "aws_instance" "public" {

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.keypair.id
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.public.id]

  associate_public_ip_address = true

  user_data_base64            = base64encode(data.local_file.userdata.content)
  user_data_replace_on_change = false

  tags = merge(
    module.tags.tags, {
      Name = format("%s-ec2-%s", var.project_name, "frontend")
    }
  )
}

# COMPUTE NOTES ----------------------------------------------------------------
# PRIVATE
resource "aws_instance" "private" {

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.keypair.id
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.private.id]

  associate_public_ip_address = false

  user_data_base64            = base64encode(data.local_file.userdata.content)
  user_data_replace_on_change = false

  tags = merge(
    module.tags.tags, {
      Name = format("%s-ec2-%s", var.project_name, "backend")
    }
  )
}