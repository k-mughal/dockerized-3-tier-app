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
resource "aws_subnet" "public_subnet_az1" { 
  vpc_id                  = aws_vpc.my3tier_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet-az1"
  }
}


# Create private subnet 2
resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.my3tier_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"  
  tags = {
    Name = "Public-Subnet-az2"
  }
}

# Create private subnet 3
resource "aws_subnet" "private_subnet_az1" {
  vpc_id                  = aws_vpc.my3tier_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"  
  tags = {
    Name = "Private_subnet_az1"
  }
}

# Create private subnet 4 in us-east-1b
resource "aws_subnet" "private_subnet_az2" {
  vpc_id                  = aws_vpc.my3tier_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"
  tags = {
    Name = "Private_subnet_az2"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "my-db-subnet-group"
  description = "My DB Subnet Group"
  subnet_ids  = [ aws_subnet.private_subnet_az1.id, aws_subnet.private_subnet_az2.id ]
  #subnet_ids  = [ aws_subnet.public_subnet_az1.id, aws_subnet.public_subnet_az2.id ]
  tags = {
    Name = "MyDBSubnetGroup"
  }
}

