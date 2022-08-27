variable "vpc_id" {
  type = string
}
variable "subnet_id" {
  type = string
}

variable "ami" {
  type    = string
  default = null
}

variable "instance_type" {
  type    = string
  default = "t3a.medium"
}
variable "name" {
  type    = string
  default = "Empty"
}

variable "user_data" {
  type    = string
  default = null
}

variable "use_eip" {
  type    = bool
  default = false
}

variable "allow_rules" {
  type = list(object({
    port                     = string
    cidr_block               = list(string)
    source_security_group_id = string
  }))
  default = []
}

variable "key_name" {
  type = string
}

variable "public_key" {
  type = string
}

variable "volume_name" {
  type    = string
  default = "EmptyName"
}

variable "volume_type" {
  type    = string
  default = "gp3"
}

variable "volume_size" {
  type    = number
  default = "10"
}

variable "iam_instance_profile" {
  type     = string
  default  = null
  nullable = true
}

variable "tags" {
  type = map(any)
  default = {
  }
}

variable "target_groups" {
  type = list(object({
    target_group_arn = string
    port             = string
  }))
  default = []
}
