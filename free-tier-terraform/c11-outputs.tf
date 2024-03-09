# Terraform Output Values

# Output the VPC ID
output "vpc_id" {
  value = aws_vpc.my3tier_vpc.id
}

output "aws_eip-public_ip" {
  value = aws_eip.nat_gateway_eip.public_ip
}

/*output "mysql_db_arn" {
  value =  aws_db_instance.maindb.arn

}

output "mysql_db_endpoint" {
  value =  aws_db_instance.maindb.endpoint
}
/*
output "Private_instance_az1_ip" {
  value = aws_instance.private_instance_az1.private_ip
}

output "Private_instance_az2_ip" {
  value = aws_instance.private_instance_az2.private_ip
  
}
################################
output "aurora_db_name_output" {
  value = aws_db_instance.maindb.db_name
}

output "aurora_cluster_arn_output" {
  value = aws_db_instance.maindb.arn
}

###########################
/*
output "aurora_db_name" {
  value = aws_rds_cluster.main.database_name
}

output "aurora_cluster_arn" {
  value = aws_rds_cluster.main.arn
}

output "aurora_secret_arn" {
  value = aws_secretsmanager_secret.secretDB.arn
}

output "db_user_arn" {
  value = aws_secretsmanager_secret.secretDB.arn
}

output "DB_USER" {
  value = local.db_creds.username
  sensitive = true
}

output "DB_PASSWORD" {
  value = local.db_creds.password
  sensitive = true
}

output "DB_HOST" {
  value = aws_rds_cluster.main.endpoint
}

output "DB_PORT" {
  value = aws_rds_cluster.main.port
  sensitive = true
}


/*

# EC2 Instance Public IP with TOSET
output "instance_publicip" {
  description = "EC2 Instance Public IP"
  #value = aws_instance.myUbuntuVM.*.public_ip   # Legacy Splat
  #value = aws_instance.myUbuntuVM[*].public_ip  # Latest Splat
  value = toset([for instance in aws_instance.myUbuntuVM: instance.public_ip])
  # aws_instance.myUbuntuVM.public_ip
  # instance.public_ip variable used from c5-ec2instance.tf
}

# EC2 Instance Public DNS with TOSET
output "instance_publicdns" {
  description = "EC2 Instance Public DNS"
  #value = aws_instance.myUbuntuVM[*].public_dns  # Legacy Splat
  #value = aws_instance.myUbuntuVM[*].public_dns  # Latest Splat
  value = toset([for instance in aws_instance.myUbuntuVM: instance.public_dns])
}

# EC2 Instance Public DNS with TOMAP
output "instance_publicdns2" {
  value = tomap({for az, instance in aws_instance.myUbuntuVM: az => instance.public_dns})
}


/*
# Additional Important Note about OUTPUTS when for_each used
1. The [*] and .* operators are intended for use with lists only. 
2. Because this resource uses for_each rather than count, 
its value in other expressions is a toset or a map, not a list.
3. With that said, we can use Function "toset" and loop with "for" 
to get the output for a list
4. For maps, we can directly use for loop to get the output and if we 
want to handle type conversion we can use "tomap" function too 
*/

