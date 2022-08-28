resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_instance" "this" {
  depends_on = [
    aws_key_pair.this
  ]
  ami                         = var.ami != null ? var.ami : data.aws_ami.amazon-linux-2.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = concat([aws_security_group.this.id], var.additional_security_group_ids)
  iam_instance_profile        = var.iam_instance_profile
  associate_public_ip_address = true
  key_name                    = aws_key_pair.this.key_name
  user_data                   = var.user_data != null ? var.user_data : file("./default_user_data.sh")
  monitoring                  = true
  tags = merge(local.tags, var.tags, {
    Name = var.name
  })
  root_block_device {
    tags = merge(local.tags, var.tags, {
      Name = var.volume_name
    })
    volume_size = var.volume_size
    volume_type = var.volume_type
  }
}

resource "aws_security_group" "this" {
  name        = "${var.name}EC2SecurityGroup"
  description = var.name
  vpc_id      = var.vpc_id
  tags = merge(var.tags, {
    Name = var.name
  })

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group_rule" "this" {
  count                    = length(var.allow_rules)
  type                     = "ingress"
  from_port                = var.allow_rules[count.index].from_port
  to_port                  = var.allow_rules[count.index].to_port
  protocol                 = var.allow_rules[count.index].protocol
  cidr_blocks              = var.allow_rules[count.index].cidr_block
  source_security_group_id = var.allow_rules[count.index].source_security_group_id
  security_group_id        = aws_security_group.this.id
}


resource "aws_eip" "this" {
  count = var.use_eip == true ? 1 : 0
  depends_on = [
    aws_instance.this
  ]
  tags = merge(local.tags, {
    Name = var.name
  })
  vpc = true
}

resource "aws_eip_association" "this" {
  count = var.use_eip == true ? 1 : 0
  depends_on = [
    aws_eip.this,
    aws_instance.this
  ]
  instance_id   = aws_instance.this.id
  allocation_id = aws_eip.this[0].id
}

resource "aws_lb_target_group_attachment" "this" {
  depends_on = [
    aws_instance.this
  ]
  count            = length(var.target_groups)
  target_group_arn = var.target_groups[count.index].target_group_arn
  target_id        = aws_instance.this.id
  port             = var.target_groups[count.index].port
}
