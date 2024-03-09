
# Create Elastic IP for NAT Gateway AZ1
resource "aws_eip" "nat_gateway_eip" {
domain     = "vpc"
}

# Create NAT Gateway 
resource "aws_nat_gateway" "my_nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id  = aws_subnet.public_subnet_az1.id
  
  tags = {
    Name = "My-NAT-Gateway"
  }
  
  #depends_on = [  ]
}


# Create Route Table AZ1
resource "aws_route_table" "private_route_table_az1" {
  vpc_id = aws_vpc.my3tier_vpc.id

  tags = {
    Name = "Private-Route-Table-az1"
  }
}

# Create Route Table AZ2
resource "aws_route_table" "private_route_table_az2" {
  vpc_id = aws_vpc.my3tier_vpc.id

  tags = {
    Name = "Private-Route-Table-az2"
  }
}

# Create Route in Route Table for NAT Gateway
resource "aws_route" "nat_gateway_route_az1" {
  route_table_id            = aws_route_table.private_route_table_az1.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.my_nat_gateway.id
}

# Create Route in Route Table for NAT Gateway
resource "aws_route" "nat_gateway_route_az2" {
  route_table_id            = aws_route_table.private_route_table_az2.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.my_nat_gateway.id
}

# Associate Route Table with private Subnet-az1
resource "aws_route_table_association" "private_subnet_association-az1" {
  depends_on = [ aws_route_table.private_route_table_az1 ]
  subnet_id      = aws_subnet.private_subnet_az1.id
  route_table_id = aws_route_table.private_route_table_az1.id
}


# Associate Route Table with private Subnet-az2
resource "aws_route_table_association" "private_subnet_association-az2" {
  depends_on = [ aws_route_table.private_route_table_az2 ]
  subnet_id      = aws_subnet.private_subnet_az2.id
  route_table_id = aws_route_table.private_route_table_az2.id

}