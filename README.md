# demo.aws-vpc-public-private-dual-ec2

---

This project creates a new VPC with public and private subnets, routing, and two EC2 nodes. 

The following resources are created, INCLUDING the custom AWS Resource Explorer view:
![aws_resourceexplorer.png](aws_resourceexplorer.png)

### Resources created:

- Resource Explorer View
- Networking
  - VPC
  - Public Subnet
  - Private Subnet
  - VPC Internet Gateway
  - Route Table
#### TODO:
- Compute
  - Security Groups
  - Key Pairs
- Compute Instances
  - t3.micro EC2 in public subnet
  - t3.micro EC2 in private subnet
