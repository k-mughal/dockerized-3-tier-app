# Create Internet Gateway
resource "aws_internet_gateway" "my3tier_igw" {
  vpc_id = aws_vpc.my3tier_vpc.id

  tags = {
    Name = "My3Tier-IGW"
  }
}


# Create route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my3tier_vpc.id

  tags = {
    Name = "Public-Route-Table"
  }
}

# Create route to the internet gateway
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my3tier_igw.id
}

# Associate route table with public subnet
resource "aws_route_table_association" "public_route_association" {
  subnet_id      = aws_subnet.public_subnet_fe.id
  route_table_id = aws_route_table.public_route_table.id
}
