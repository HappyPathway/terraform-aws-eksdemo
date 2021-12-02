variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  default = ["10.0.5.0/24", "10.0.6.0/24"]
  type    = list(any)
}

variable "private_subnet_cidrs" {
  default = ["10.0.7.0/24", "10.0.8.0/24"]
  type    = list(any)
}

variable "network_name" {
  type        = string
  description = "Specify the name of the network"
}

variable "key_name" {
  type        = string
  description = "Specify AWS KeyPair"
}

variable "availability_zones" {
  type        = list(any)
  description = "AZ where resources will live"
  default     = ["us-east-1b", "us-east-1c"]
}

variable "env" {
  default = "eksdemo"
}

variable "image" {
  default = "nginx:1.7.9"
}