variable "vpc_id" {
  type = string
}
variable "name" {
  type = string
}

variable "description" {
  type = string
}

variable "tags" {
  type = map(any)
  default = {
  }
}
