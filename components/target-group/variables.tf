variable "vpc_cidr" {
  type = string
}

variable "name" {
  type = string
}

variable "port" {
  type = number
}

variable "protocol" {
  type    = string
  default = "HTTP"
}

variable "health_check_path" {
  type    = string
  default = "/"
}

variable "health_check_matcher" {
  type    = string
  default = "200,404"
}

variable "tags" {
  type = map(any)
  default = {
  }
}
