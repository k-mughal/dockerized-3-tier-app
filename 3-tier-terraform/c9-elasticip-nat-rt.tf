
# Create Elastic IP for NAT Gateway
resource "aws_eip" "nat_gateway_eip" {
domain     = "vpc"
}

# Create NAT Gateway
resource "aws_nat_gateway" "my_nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  #subnet_id     = aws_subnet.public_subnet.id
  subnet_id  = aws_subnet.public_subnet_fe.id
  
  tags = {
    Name = "My-NAT-Gateway"
  }

  #depends_on = [aws_subnet.public_subnet]
  depends_on = [aws_instance.public_instance_fe, aws_vpc.my3tier_vpc]
}


# Create Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my3tier_vpc.id

  tags = {
    Name = "Private-Route-Table"
  }
}

# Create Route in Route Table for NAT Gateway
resource "aws_route" "nat_gateway_route" {
  route_table_id            = aws_route_table.private_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.my_nat_gateway.id
}

# Associate Route Table with Public Subnet
resource "aws_route_table_association" "private_subnet_association" {
  depends_on = [ aws_route_table.private_route_table ]
  subnet_id      = aws_subnet.private_subnet_be.id
  route_table_id = aws_route_table.private_route_table.id
}

