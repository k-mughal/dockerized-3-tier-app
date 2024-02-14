# Get latest AMI ID for Ubuntu linux OS
data "aws_ami" "ubuntu" { # data.aws_ami.ubuntu.id
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}


