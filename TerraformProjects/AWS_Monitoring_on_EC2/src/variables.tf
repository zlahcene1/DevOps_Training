variable "region" {
  description = "Choose a region"
  type        = string
}

variable "ip_vpc" {
  description = "Choose your IP network (example: 10.80.0.0/16)"
  type        = string
  //depends_on[var.region]
}

variable "ip_subnet" {
  description = "Choose you IP subnet (example: 10.80.1.0/24)"
  type        = string
  //depends_on = [var.ip_vpc]
}

variable "mail" {
  description = "Choose an email for altert's"
  type        = string
  //depends_on = [var.ip_subnet, var.region]
}

variable "ip_all" {
  type    = string
  default = "0.0.0.0/0"
}
