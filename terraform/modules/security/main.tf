resource "aws_security_group" "dev_sg" {
  name        = "dev_sg"
  description = "Developer security group"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Local Public IP"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [local.public_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
} 