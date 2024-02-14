# Get latest AMI ID for Amazon Linux2 OS
data "aws_ami" "amzlinux2" { # data.aws_ami.amzlinux2.id
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    #values = [ "amzn2-ami-hvm-*-gp2" ]
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
