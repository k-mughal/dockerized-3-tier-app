# AWS EC2 Security Group Terraform Module
# Security Group for Public Bastion Host
module "public_bastion_sg" { #  module.public_bastion_sg.security_group_id
                             #  module.public_bastion_sg.security_group_vpc_id
                             #  module.public_bastion_sg.security_group_name
                             #  above variables used in c5-c02-securitygroup-output.tf

  source  = "terraform-aws-modules/security-group/aws"
  #version = "3.18.0"
  version = "5.1.0"

  name = "public-bastion-sg"
  description = "Security Group with SSH port open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id # variable defined in c4-03-vpc-outputs.tf
  # Ingress Rules & CIDR Blocks
  ingress_rules = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = local.common_tags # tag are defined in c3-local-values.tf
}
