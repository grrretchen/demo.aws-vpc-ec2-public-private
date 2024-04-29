# demo.aws-vpc-public-private-ec2

---

This project uses Terraform to create a new VPC with public and private subnets, routing, and two EC2 nodes.
![demo.aws-vpc-ec2-public-private.png](demo.aws-vpc-ec2-public-private.png)

### Project Goals:
- Demonstrate a one-touch infrastructure-as-code Terraform project
- Demonstrate a tagging strategy
- Demonstrate AWS Resource Explorer

The following resources are created, INCLUDING the custom AWS Resource Explorer view:
![aws_resourceexplorer.png](aws_resourceexplorer.png)

The project deploys from scratch in less than one minute:
![terminal-output-create.png](terminal-output-create.png)

And can be completely destroyed in about the same:
![terminal-output-destroy.png](terminal-output-destroy.png)

### Resources created:

- Resource Explorer View
- Networking
  - VPC
  - Public Subnet
  - Private Subnet
  - VPC Internet Gateway
  - Route Table
- Compute
  - Key Pairs
  - Security Groups
- Compute Instances
  - t3.micro EC2 in public subnet
  - t3.micro EC2 in private subnet

### Usage:
- Preconditions:
  - AWS account
  - AWS environment variables are set up in terminal
    - `AWS_ACCESS_KEY_ID`
    - `AWS_SECRET_ACCESS_KEY` 
    - `AWS_SESSION_TOKEN`
  - Terraform installed locally

### Execution:
  - `cd terraform`
  - `terraform plan`
  - `terraform apply`
  - `terraform destroy`

### Customization:
- `terraform/default.auto.tfvars` - quickly modify project settings.
- `terraform/id_ssh.pub` - replace this with YOUR ssh public key
- `terraform/userdata.txt` - customize the EC2 first-launch script