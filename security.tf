resource "aws_security_group" "dev_sg" {
  name        = "dev_sg"
  description = "Developer security group"
  vpc_id      = aws_vpc.vpc.id

  # dynamically find IP
  ingress {
    description = "Local Public IP"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["152.208.42.110/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
} 