resource "aws_instance" "web" {
  ami                         = "ami-055d15d9cfddf7bd3"
  instance_type               = "t3.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.sg.id]
  associate_public_ip_address = true
  tags = {
    Name = "grunttest"
  }
  key_name = aws_key_pair.key.key_name
  root_block_device {
    tags        = {
      Name =  "tag"
    }
    volume_size = 10
    volume_type = "gp3"
  }
}

resource "aws_security_group" "sg" {
  name        = "sgtest"
  description = "sgtest"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "tg-test-sg"
  }
}

resource "aws_key_pair" "key" {
  key_name   = "gruntkey"
  public_key = var.pubkey
}
