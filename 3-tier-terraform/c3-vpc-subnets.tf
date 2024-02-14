# Create VPC
resource "aws_vpc" "my3tier_vpc" { 
  cidr_block           = "10.0.0.0/16" 
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "my3tier-vpc"
  }
}

# Create public subnet 1
resource "aws_subnet" "public_subnet_fe" { 
  vpc_id                  = aws_vpc.my3tier_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet-fe"
  }
}


# Create private subnet 2
resource "aws_subnet" "private_subnet_be" {
  vpc_id                  = aws_vpc.my3tier_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"  
  tags = {
    Name = "Private-Subnet-be"
  }
}

# Create private subnet 3
resource "aws_subnet" "private_subnet_db" {
  vpc_id                  = aws_vpc.my3tier_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"  
  tags = {
    Name = "Private-Subnet-db-AZ1"
  }
}

# Create private subnet 4 in us-east-1b
resource "aws_subnet" "private_subnet_db_az2" {
  vpc_id                  = aws_vpc.my3tier_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"
  tags = {
    Name = "Private-Subnet-db-AZ2"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "my-db-subnet-group"
  description = "My DB Subnet Group"
  subnet_ids  = [ aws_subnet.private_subnet_db.id, aws_subnet.private_subnet_db_az2.id ]

  tags = {
    Name = "MyDBSubnetGroup"
  }
}

