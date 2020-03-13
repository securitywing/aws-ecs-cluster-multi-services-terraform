variable "CLUSTER_NAME" {}
variable "VPC_ID" {}
variable "AWS_REGION" {}
variable "APPLICATION_NAME" {}
variable "APPLICATION_PORT" {}
variable "APPLICATION_VERSION" {}
variable "CLUSTER_ARN" {}
variable "SERVICE_ROLE_ARN" {}
variable "DESIRED_COUNT" {}
variable "DEPLOYMENT_MINIMUM_HEALTHY_PERCENT" {
  default = 100
}

variable "DEPLOYMENT_MAXIMUM_PERCENT" {
  default = 200
}

variable "DEREGISTRATION_DELAY" {
  default = 30
}

variable "HEALTHCHECK_MATCHER" {
  default = "200"
}

variable "CPU_RESERVATION" {}
variable "MEMORY_RESERVATION" {}
variable "LOG_GROUP" {}


variable "ALB_ARN" {}



#variable "vpc-id" { }


#variable "private_subnets" {}
variable "VPC_SUBNETS" {}
