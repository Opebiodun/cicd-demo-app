# Project Configuration
variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "cicd-demo"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

# Networking
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

# EC2 Configuration
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
  default     = "my-ec2-key"
}

variable "my_ip" {
  description = "Your IP address for SSH access (CIDR notation)"
  type        = string
  default     = "************/32"
  # Change to your IP: "YOUR_IP/32"
}

# GitHub Configuration
variable "github_repo" {
  description = "GitHub repository in format: Opebiodun/cicd-demo-app"
  type        = string
  # Example: "Opebiodun/cicd-demo-app"
}

variable "github_branch" {
  description = "GitHub branch to track"
  type        = string
  default     = "main"
}