# Create EC2-Frontend/Bastion Server instance in public subnet
resource "aws_instance" "public_instance_fe" { 
  ami           = data.aws_ami.ubuntu.id 
  instance_type = var.instance_type 

  user_data = file("${path.module}/frontend-install.sh")
  key_name = var.instance_keypair
  
  subnet_id = aws_subnet.public_subnet_fe.id  
  vpc_security_group_ids = [ 
    aws_security_group.vpc-ssh.id, 
    aws_security_group.vpc-web.id   ]

  tags = {
    Name = "FrontEnd-Public-Server"
  }
}

resource "aws_instance" "private_instance_be" { 
  depends_on = [ aws_nat_gateway.my_nat_gateway ]
  ami           = data.aws_ami.ubuntu.id  
  instance_type = var.instance_type 
  
  user_data = file("${path.module}/backend-install.sh")

  key_name = var.instance_keypair 
  
  subnet_id = aws_subnet.private_subnet_be.id
  vpc_security_group_ids = [ aws_security_group.vpc-ssh.id]
    
  tags = {
    Name = "BackEnd-Private-Server"
  }
}

/*
resource "aws_instance" "private_instance_db" {
  ami           = data.aws_ami.ubuntu.id # this id used from c4-ami-datasource.tf 
  instance_type = var.instance_type # this veriable define in c2-varialbes.tf

  key_name = var.instance_keypair # this veriable define in c2-varialbes.tf
  
  subnet_id = aws_subnet.private_subnet_db.id  # Use the other public subnet
  vpc_security_group_ids = [ aws_security_group.vpc-ssh.id] # this variable defined in c2-variable.tf
  
  tags = {
    Name = "Database-Private-Server"
  }


}  
*/
