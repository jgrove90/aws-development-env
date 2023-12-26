resource "aws_key_pair" "auth" {
  key_name   = "aws_ec2_key"
  public_key = file("~/.ssh/aws_ec2_key.pub")
}

resource "aws_instance" "dev_node" {
  ami                    = data.aws_ami.ubuntu_image.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.auth.id
  vpc_security_group_ids = [aws_security_group.dev_sg.id]
  subnet_id              = aws_subnet.public_subnet.id
  user_data              = file("userdata.tpl")

  root_block_device {
    volume_size = 10
  }

  # replace with ansible  
  provisioner "local-exec" {
    command = templatefile("${var.host_os}-ssh-config.tpl", {
      hostname     = self.public_ip,
      user         = "ubuntu",
      identityfile = "~/.ssh/aws_ec2_key"
    })

    interpreter = var.host_os == "windows" ? ["Powershell", "-Command"] : ["bash", "-c"]
  }


  tags = {
    Name = "dev-node"
  }
}