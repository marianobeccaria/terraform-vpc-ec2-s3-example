variable "profile" {
  type    = string
  default = "terraform"
}

variable "region-master" {
  type    = string
  default = "us-east-1"
}

variable "external_ip" {
  type = string
  default = "0.0.0.0/0"
}