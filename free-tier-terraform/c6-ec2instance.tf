# Create EC2-Frontend/Bastion Server instance in public subnet
resource "aws_instance" "bastion_server_az1" { 
  ami           = data.aws_ami.ubuntu.id 
  instance_type = var.instance_type 

  #user_data = file("${path.module}/frontend-install.sh")
  key_name = var.instance_keypair 
  
  subnet_id = aws_subnet.public_subnet_az1.id 
  vpc_security_group_ids = [ 
    aws_security_group.vpc-ssh.id, 
    aws_security_group.vpc-web.id   ]

  tags = {
    Name = "Bastion Server"
  }
}
