variable "profile" {
  type    = string
  default = "terraform"
}

variable "region-master" {
  type    = string
  default = "us-east-1"
}

variable "external_ip" {
  type    = string
  default = "0.0.0.0/0"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ebs_vol_size" {
  type    = number 
  default = 10
}

variable "my_bucket_name" {
  type    = string
  default = "tf-example-mariano-11645232twerer"
}