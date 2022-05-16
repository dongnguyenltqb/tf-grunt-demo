variable "cidr_block" {
  type     = string
  nullable = false
}

variable "tags" {
  type = map(any)
}
