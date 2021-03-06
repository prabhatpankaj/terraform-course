variable "aws_profile" {
  type    = string
  default = "default"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "image_name" {
  type    = string
  default = "jenkins"
}

variable "availability_zone" {
  description = "The availability zone"
  default     = "us-east-1b"
}

variable "ecs_cluster_name" {
  description = "The name of the Amazon ECS cluster."
  default     = "jenkins-ecs"
}

variable "amis" {
  description = "Which AMI to spawn. Defaults to the AWS ECS optimized images."
  default = {
    us-east-1 = "ami-08b26b905b0d17561"
  }
}

variable "instance_type" {
  default = "t3.medium"
}

variable "key_name" {
  default     = "kantlearning"
  description = "SSH key name in your AWS account for AWS instances."
}

variable "min_instance_size" {
  default     = 1
  description = "Minimum number of EC2 instances."
}

variable "max_instance_size" {
  default     = 2
  description = "Maximum number of EC2 instances."
}

variable "desired_instance_capacity" {
  default     = 1
  description = "Desired number of EC2 instances."
}

variable "desired_service_count" {
  default     = 1
  description = "Desired number of ECS services."
}

variable "s3_bucket" {
  default     = "terraformstatekant"
  description = "S3 bucket where remote state and Jenkins data will be stored."
}

variable "restore_backup" {
  default     = true
  description = "Whether or not to restore Jenkins backup."
}

variable "jenkins_repository_url" {
  default     = "jenkins"
  description = "ECR Repository for Jenkins."
}

variable "container_port" {
  default     = "8080"
  description = "Docker Container Port."
}

variable "agent_port" {
  default     = "50000"
  description = "Jenins Agent Port."
}

variable "aws_dns_zone_holder_profile_name" {
  type        = string
  default     = "default"
  description = "Local AWS profile to use for the AWS account where the dns zone is maintaned"
}

variable "subdomain_zone_name" {
  type    = string
  default = "jenkins"
}

variable "dns_zone_name" {
  type    = string
  default = "kantlearning.com"
}

variable "hosts_name" {
  type    = string
  default = "*.kantlearning.com"
}

variable "build_trigger" {
  default = "18"
}

variable "iam_role_jenkins" {
  type    = string
  default = "host_role_jenkins-ecs_custom"
}

variable "vpc" {
  type    = string
  default = "vpc-0c646dec282777397"
}

variable "aws_security_group_jenkins_alb_id" {
  type    = string
  default = "sg-0274d06f7db34b19b"
}

variable "aws_security_group_jenkins_ecs_id" {
  type    = string
  default = "sg-077cb68722904b6d0"
}

variable "alb_subnet_ids" {
  type    = string
  default = "subnet-0edf451e03366d61d,subnet-0ac094039d9ff484b,subnet-08846c94d3c01f41c"
  
}
