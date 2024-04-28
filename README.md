# demo.aws-vpc-public-private-ec2

---

This project creates a new VPC with public and private subnets, routing, and two EC2 nodes. 

![demo.aws-vpc-ec2-public-private.png](demo.aws-vpc-ec2-public-private.png)

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
