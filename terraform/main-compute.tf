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