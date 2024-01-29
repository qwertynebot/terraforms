provider "aws" {
  region = "eu-north-1"
  access_key = "AccessKey"
  secret_key = "SecretKeey"
}

resource "aws_instance" "apache_instance" {
  ami           = "ami-0fe8bec493a81c7da"
  instance_type = "t3.micro"
  key_name      = "Kluc" 

  root_block_device {
    volume_size = 18 
  }

  tags = {
    Name = "apache-instance"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              systemctl enable apache2
              systemctl start apache2
              EOF
}

resource "aws_instance" "tomcat_instance" {
  ami           = "ami-0fe8bec493a81c7da"
  instance_type = "t3.micro"
  key_name      = "Kluc"

  root_block_device {
    volume_size = 11
  }

  tags = {
    Name = "tomcat-instance"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y tomcat9
              systemctl enable tomcat9
              systemctl start tomcat9
              EOF
}
