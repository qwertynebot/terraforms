provider "aws" {
  region = "eu-north-1"
  access_key = ""
  secret_key = ""

}

resource "aws_instance" "EC2-Instance" {
availability_zone = "eu-north-1a" 
ami = "ami-0989fb15ce71ba39e"
instance_type = "t3.micro"
key_name = "Kluc"
vpc_security_group_ids = [aws_security_group.DefaultTerraFormSG.id]

ebs_block_device {
  device_name = "/dev/sdal"
  volume_size = 10
  volume_type = "standard"
tags = {
 Name = "root-disc"
  }
}

user_data = file("files/install.sh")

tags = {
 Name = "EC2-Instance"
   }
 }

resource "aws_security_group" "DefaultTerraFormSG" {
  name = "DefaultTerraFormSG"
  description = "Allow 22, 80, 443 inbound taffic"

ingress {
    description = "Allow HTTPS"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

ingress = {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

ingress {
    description = "Allow SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
