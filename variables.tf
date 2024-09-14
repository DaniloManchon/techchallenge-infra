variable "aws_access_key" {
  description = "AWS Access key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret key"
  type        = string
  sensitive   = true
}

variable "aws_session_token" {
  description = "AWS Session token"
  type        = string
  sensitive   = true
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "node_role_arn" {
  description = "ARN of the IAM Role that will be associated with the Node Group"
  type        = string
  sensitive   = true
}

variable "availability_zones" {
  description = "List of availability zones where the subnets will be created"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "cluster_name" {
  description = "Name of the EKS Cluster"
  type        = string
  default     = "techchallenge-cluster"
}

variable "node_group_name" {
  description = "Name of Node Group"
  type        = string
  default     = "techchallenge_node_group"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.small"
}

variable "ami_type" {
  description = "ami used on EC2"
  type        = string
  default     = "AL2_x86_64"
}