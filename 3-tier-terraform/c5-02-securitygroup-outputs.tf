# AWS EC2 Security Group Terraform Outputs

# *************Public Bastion Host Security Group Outputs**********************
## public_bastion_sg_group_id
output "public_bastion_sg_group_id" {
  description = "The ID of the security group"
  value       = module.public_bastion_sg.security_group_id # variable defined in c5-02-securitygroup-bastionsg.tf
}

## public_bastion_sg_group_vpc_id
output "public_bastion_sg_group_vpc_id" {
  description = "The VPC ID"
  value       = module.public_bastion_sg.security_group_vpc_id # variable defined in c5-03-securitygroup-bastionsg.tf
}

## public_bastion_sg_group_name
output "public_bastion_sg_group_name" {
  description = "The name of the security group"
  value       = module.public_bastion_sg.security_group_name # variable defined in c5-03-securitygroup-bastionsg.tf
}

# *************Private EC2 Instances Security Group Outputs**********************
## private_sg_group_id
output "private_sg_group_id" {
  description = "The ID of the security group"
  value       = module.private_sg.security_group_id # variable defined in c5-04-securitygroup-privatesg.tf
}

## private_sg_group_vpc_id
output "private_sg_group_vpc_id" {
  description = "The VPC ID"
  value       = module.private_sg.security_group_vpc_id # variable defined in c5-04-securitygroup-privatesg.tf
}

## private_sg_group_name
output "private_sg_group_name" {
  description = "The name of the security group"
  value       = module.private_sg.security_group_name # variable defined in c5-04-securitygroup-privatesg.tf
}

