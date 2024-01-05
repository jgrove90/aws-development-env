variable "host_os" {
  description = "The OS of the host machine"
  type        = string
  default     = "linux"
}

variable "ssh_key" {
  description = "The name of the ssh key to use"
  type        = string
  default     = "aws_key"
}

variable "instance_type" {
  description = "The type of instance to create"
  type        = string
  default     = "t2.micro"
}