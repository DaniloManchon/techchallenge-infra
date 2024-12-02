variable "aws_account_id" {
  description = "AWS account id"
  type        = string
  default     = "211125578611"
}

variable "node_role_arn" {
  description = "ARN of the IAM Role that will be associated with the Node Group"
  type        = string
  sensitive   = true
  default     = "arn:aws:iam::211125578611:role/LabRole"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "List of availability zones where the subnets will be created"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "cluster_name" {
  description = "Name of the EKS Cluster"
  type        = string
  default     = "techchallenge"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.medium"
}

variable "ami_type" {
  description = "AMI used on EC2"
  type        = string
  default     = "AL2_x86_64"
}

variable "timer_value" {
  description = "value for wait ingress NLB creation"
  type        = string
  default     = "5m"
}
