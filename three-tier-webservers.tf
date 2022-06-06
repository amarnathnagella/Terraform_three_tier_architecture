#Create EC2 instance
resource "aws_instance" "webserver1" {
  ami                    = "ami-0b404894f3a1e6da0"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]
  subnet_id              = aws_subnet.web-subnet-1.id
  user_data              = file("three-tier-install-apache.sh")

  tags = {
    name = "Web Server"
  }
}

resource "aws_instance" "webserver2" {
  ami                    = "ami-0b404894f3a1e6da0"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1b"
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]
  subnet_id              = aws_subnet.web-subnet-2.id
  user_data              = file("three-tier-install-apache.sh")

  tags = {
    name = "Web Server"
  }
}
