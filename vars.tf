variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "vpc-id" {
   default = "vpc-fec94a98"
 }
# EC2 instance private subnet with NAT gateway
variable "private_subnets" {
  default = [ "subnet-1371d55b", "subnet-7ea97f18" ]
}

# ALB public subnets
variable "public_subnets" {
   default = [ "subnet-1371d55b", "subnet-7ea97f18" ]
}

# Type the key name that has  already been upload in the AWS. Replace the default value by the keypair that you created in the AWS. 
variable "key_name" {
   default = "your-keypair"
}

