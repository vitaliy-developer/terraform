#----------------------
# My terraform_remote_state
# Build WebServer during Bootstrap
#
# Made by Vitaliy Katkalo

provider "aws" {
  region = "eu-central-1"
}

# my server with security group
resource "aws_instance" "my_webserver" {
  #count                  = 1                       #создаеться 1 host
  ami                    = "ami-00aa4671cbf840d82" #Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id] #add security group
  #bash script for our server
  user_data = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with IP: $myip</h2> <br>Build by Terraform!" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF

  tags = {
    Name    = "My Amazon Server"
    Owner   = "Vitaliy Katkalo"
    Project = "Terraform Lessons"
  }
}

#security group
resource "aws_security_group" "my_webserver" {
  name        = "WebServer Securiry Group"
  description = "My First Security Group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "WebServer Securiry Group Terraform"
    Owner   = "Vitaliy Katkalo"
    Project = "Terraform Lessons"
  }

}
