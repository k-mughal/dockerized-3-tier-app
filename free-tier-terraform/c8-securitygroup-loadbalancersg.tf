# Security Group for Public Load Balancer
resource "aws_security_group" "loadbalancer_sg" {
  name        = "loadbalancer-sg"
  description = "Security Group with HTTP open for entire Internet (IPv4 CIDR), egress ports are all world open"
  vpc_id = aws_vpc.my3tier_vpc.id

  # Ingress Rules & CIDR Blocks
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress Rule - all-all open
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Additional Ingress Rule for port 81
  ingress {
    from_port   = 81
    to_port     = 81
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow Port 81 from internet"
  }

}



