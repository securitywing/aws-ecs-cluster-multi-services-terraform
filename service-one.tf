data "aws_caller_identity" "current" {}

module "tf-ecs" {
  source         = "./modules/terraform-ecs/ecs-cluster"
  VPC_ID         = "${var.vpc-id}"
  CLUSTER_NAME   = "example-cluster"
  INSTANCE_TYPE  = "t3.micro"
  SSH_KEY_NAME   = "${var.key_name}"
  VPC_SUBNETS    = "${join(",", var.private_subnets)}"
  ENABLE_SSH     = true
  SSH_SG         = "${aws_security_group.allow-ssh.id}"
  LOG_GROUP      = "example-ecs-log-group"
  AWS_ACCOUNT_ID = "${data.aws_caller_identity.current.account_id}"
  AWS_REGION     = "${var.AWS_REGION}"
}
module "tf-service" {
  source              = "./modules/terraform-ecs/service-one"
  VPC_ID              = "${var.vpc-id}"
  APPLICATION_NAME    = "service-one"
  APPLICATION_PORT    = "80"
  APPLICATION_VERSION = "latest"
  CLUSTER_ARN         = "${module.tf-ecs.cluster_arn}"
  SERVICE_ROLE_ARN    = "${module.tf-ecs.service_role_arn}"
  AWS_REGION          = "${var.AWS_REGION}"
  HEALTHCHECK_MATCHER = "200"
  CPU_RESERVATION     = "256"
  MEMORY_RESERVATION  = "128"
  LOG_GROUP           = "example-ecs-log-group"
  DESIRED_COUNT       = 1
  ALB_ARN             = "${module.tf-alb.alb_arn}"
  CLUSTER_NAME        = "example-cluster"
  VPC_SUBNETS         = "${join(",", var.private_subnets)}"
}
module "tf-alb" {
  source             = "./modules/terraform-ecs/alb"
  VPC_ID         = "${var.vpc-id}"
  ALB_NAME           = "example-ecs-alb"
  VPC_SUBNETS    = "${join(",", var.public_subnets)}"
  DEFAULT_TARGET_ARN = "${module.tf-service.target_group_arn}"
  DOMAIN             = "*.sixthgalaxy.com"
  INTERNAL           = false
  ECS_SG             = "${module.tf-ecs.cluster_sg}"
}
module "tf-alb-rule" {
  source             = "./modules/terraform-ecs/alb-rule"
  LISTENER_ARN       = "${module.tf-alb.https_listener_arn}"
  PRIORITY           = 100
  TARGET_GROUP_ARN   = "${module.tf-service.target_group_arn}"
  CONDITION_FIELD    = "host-header"
  CONDITION_VALUES   = ["service-one.sixthgalaxy.com"]
}
