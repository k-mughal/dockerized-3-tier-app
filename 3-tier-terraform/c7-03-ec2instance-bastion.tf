# AWS EC2 Instance Terraform Module
# Bastion Host - EC2 Instance that will be created in VPC Public Subnet
module "ec2_public" { # module.ec2_public.id
  source  = "terraform-aws-modules/ec2-instance/aws"
  #version = "2.17.0"
  version = "5.5.0"
  # insert the 10 required variables here
  name                   = "${var.environment}-FrontEnd-Server" # defined in c3-local-values.tf
  #instance_count         = 5
  ami                    = data.aws_ami.amzlinux2.id # variable used from c6-01-datasource-ami.tf
  instance_type          = var.instance_type # defined in c7-01-ec2instance-variables.tf
  key_name               = var.instance_keypair # defined in c7-01-ec2instance-variables.tf
  #monitoring             = true
  subnet_id              = module.vpc.public_subnets[0] # defined in c4-03-vpc-outputs.tf
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id] # defined in c5-02-securitgroup-outputs.tf
  tags = local.common_tags # defined in c3-local-values.tf
}

