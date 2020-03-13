module "service-two" {
  source              = "./modules/terraform-ecs/service-two"
  VPC_ID              = "${var.vpc-id}"
  APPLICATION_NAME    = "service-two"
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
  NAME_SPACE_ID       = "${module.tf-service.ecs_private_namespace_id}"
  CLUSTER_NAME        = "example-cluster"
  VPC_SUBNETS         = "${join(",", var.private_subnets)}"
}

module "service-two-tf-alb-rule" {
  source             = "./modules/terraform-ecs/alb-rule"
  LISTENER_ARN       = "${module.tf-alb.https_listener_arn}"
  PRIORITY           = 130
  TARGET_GROUP_ARN   = "${module.service-two.target_group_arn}"
  CONDITION_FIELD    = "host-header"
  CONDITION_VALUES   = ["service-two.sixthgalaxy.com"]
}

