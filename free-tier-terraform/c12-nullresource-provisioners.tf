
# Create a Null Resource and Provisioners
resource "null_resource" "name" {
  depends_on = [ aws_instance.bastion_server_az1 ]

  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type     = "ssh" 
    #host     = aws_instance.public_instance_fe.public_ip
    host     = aws_instance.bastion_server_az1.public_ip
    user     = "ubuntu"
    password = ""
    private_key = file("private-key/terraform-key1.pem")
  }  



    ## File Provisioner: Copies the terraform-key.pem file to /tmp/terraform-key.pem
    provisioner "file" {
      source      = "private-key/terraform-key1.pem"
      destination = "/tmp/terraform-key1.pem"
    }

    ## Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
    provisioner "remote-exec" {
      inline = [
        "sudo chmod 400 /tmp/terraform-key1.pem"
        
      ]
    }

}