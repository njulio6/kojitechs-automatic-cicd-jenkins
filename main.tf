
locals {
  instance_profile = aws_iam_instance_profile.instance_profile.name
}

data "aws_ami" "ami" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# aws_instance.jenkins-build-agent.pulic_ip

resource "aws_instance" "jenkins-build-agent" {
  ami                    = data.aws_ami.ami.id
  instance_type          = "t2.xlarge"
  vpc_security_group_ids = [aws_security_group.jenkins.id]
  user_data              = file("${path.module}/template/jenkins.sh")
  iam_instance_profile   = local.instance_profile

  tags = {
    Name = "jenkins-build-agent"
  }
}

