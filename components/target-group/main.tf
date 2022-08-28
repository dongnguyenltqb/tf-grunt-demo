resource "aws_lb_target_group" "this" {
  name     = var.name
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_cidr
  health_check {
    enabled = true
    path    = var.health_check_path
    matcher = var.health_check_matcher
  }
  tags = merge(local.tags, var.tags, {
    Name = var.name
  })
}
