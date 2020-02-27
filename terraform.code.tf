# *************************
# vars.tf
# *************************
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-east-2"
}
variable "AMIS" {
  type = "map"
  default = {
    # ********************************************
    # https://cloud-images.ubuntu.com/locator/ec2/
    #
    # Ohio    => us-east-2
    # OS      => UBUNTU Bionic 18.04 LTS
    # AMI_ID  => ami-0367b500fdcac0edc
    #
    # AMI shortcut (AMAZON MACHINE IMAGE)
    #
    # *******************************************
    us-east-2 = "ami-0367b500fdcac0edc"
  }
}

# ***************************
# provider.tf
# ***************************
provider "aws" {
  version = "~> 2.50"
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
  region = "${var.AWS_REGION}"
}

# ***************************
# instance.tf
# ***************************
resource "aws_instance" "UDEMY_DEVOPSINUSE" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  tags = { Name = "UDEMY" }
  instance_type = "t2.micro"
  provisioner "local-exec" {
    command = "echo ${aws_instance.UDEMY_DEVOPSINUSE.private_ip} >> private_ips.txt"
  }
}
output "ip" {
  value = "${aws_instance.UDEMY_DEVOPSINUSE.public_ip}"
}
