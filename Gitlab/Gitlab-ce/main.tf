resource "aws_key_pair" "parvinkeypair" {
  key_name   = "parvinkeypair"
  public_key = var.public_key
}

resource "aws_security_group" "gitlab-security-group" {
  name_prefix = "gitlab-security-group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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
}

resource "aws_instance" "gitlab_instance" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = aws_key_pair.parvinkeypair.key_name
  security_groups = [aws_security_group.gitlab-security-group.name]

  root_block_device {
    volume_size = 100
    volume_type = "gp2"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("$HOME/.ssh/id_rsa")

    host = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y curl openssh-server ca-certificates tzdata perl",
      " curl  https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash",
      "sudo apt-get install -y gitlab-ce",
      "sudo gitlab-ctl reconfigure"
    ]
  }
  tags = {
    Name = "GitLab Instance"
  }
}
