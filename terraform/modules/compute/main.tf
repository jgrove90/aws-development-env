resource "aws_key_pair" "auth" {
  key_name   = "aws_key"
  public_key = file("~/.ssh/${var.ssh_key}.pub")
}

resource "aws_instance" "dev_node" {
  ami                    = data.aws_ami.ubuntu_image.id
  instance_type          = var.instance_type
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
      identityfile = "~/.ssh/${var.ssh_key}"
    })

    interpreter = var.host_os == "windows" ? ["Powershell", "-Command"] : ["bash", "-c"]
  }

  tags = {
    Name = "dev-node"
  }
}