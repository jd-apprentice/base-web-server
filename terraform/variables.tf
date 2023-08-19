#------------------------------------------------------------------------------
# AWS
#------------------------------------------------------------------------------

variable "zone" {
  description = "zone"
  type        = string
  default     = "us-east-1a" # Change this to your zone
}

variable "aws_region" {
  description = "aws_region"
  type        = string
  default     = "us-east-1" # Change this to your region
}

variable "access_key" {
  description = "access_key"
  type        = string
  sensitive   = true
  default     = ""
}

variable "secret_key" {
  description = "secret_key"
  type        = string
  sensitive   = true
  default     = ""
}

variable "ami" {
  description = "ami"
  type        = string
  default     = "ami-08a52ddb321b32a8c" # Verify the latest AMI for your region
}

variable "instance_type" {
  description = "instance_type"
  type        = string
  default     = "t2.micro"
}

variable "ssh_key" {
  description = "ssh key location"
  type        = string
  default     = "" # Your SSH key location
}
