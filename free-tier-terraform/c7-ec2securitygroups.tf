
# Create Security Group - Web Traffic
resource "aws_security_group" "vpc-web" {
  name        = "SG-Frontend"
  description = "Port 80, 443 allowed"
  vpc_id = aws_vpc.my3tier_vpc.id
  
  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  
  egress {
    description = "Allow all ip and ports outbound"    
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG-Frontend"
  }
}



# Create Security Group - SSH Traffic
resource "aws_security_group" "vpc-ssh" { # aws_security_group.vpc-ssh.id
                                          
  name        = "SG-BE-SSH"
  description = "SG - Port 22 allowed"
  # vpc_id = aws_vpc.main.id # it will be default vpc if no vpc id is defined
  vpc_id = aws_vpc.my3tier_vpc.id
  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    

  }
  ingress {
    description = "Allow 5000 SG-frontend"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.vpc-web.id]

  }


  egress {
    description = "Allow all ip and ports outbound"    
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG-Backend"
  }
}

# Create Security Group - Database
resource "aws_security_group" "db-sg" {
  name        = "SG-Database"
  description = "Allow inbound traffic to MySql"
  vpc_id = aws_vpc.my3tier_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   # security_groups = [aws_security_group.vpc-ssh.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

