#Create SG for allowing TCP/22 from public subnet to private subnet
resource "aws_security_group" "sg-public-to-private" {
  provider = aws.region-master

  name        = "tf-example-sg-public-to-private"
  description = "Allow TCP/22 from public to private only"
  vpc_id      = aws_vpc.vpc_master.id
  ingress {
    description = "Allow traffic only from public subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.4.1.0/24"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Create SG for allowing TCP/22 from internet to public subnet
resource "aws_security_group" "sg-internet-public" {
  provider = aws.region-master

  name        = "tf-example-sg-internet-public"
  description = "Allow TCP/22 from internet to public subnet"
  vpc_id      = aws_vpc.vpc_master.id
  ingress {
    description = "Allow 22 from public "
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.external_ip]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}