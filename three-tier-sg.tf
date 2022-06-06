#Create web security group
resource "aws_security_group" "web-sg" {
  name        = "web-sg"
  description = "allow http inbound traffic"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description = "http from vpc"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = ""
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #tags {
  #  name = "web-sg"
  #}
}

#Create web server security group
resource "aws_security_group" "webserver-sg" {
  name        = "webserver-sg"
  description = "allow inbound traffic from alb"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description = "allow traffic from web layer"
    from_port   = 80
    protocol    = 80
    to_port     = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #tags {
  #  Name = "webserver-sg"
  #}
}

#create database sercurity group
resource "aws_security_group" "database-sg" {
  name        = "database-sg"
  description = "allow inbound traffic from application layer"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description     = "allow traffic from application layer"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.webserver-sg.id]
  }
  egress {
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #tags {
  #  name = "database-sg"
  #}
}
