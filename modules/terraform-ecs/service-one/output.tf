output "target_group_arn" {
  value = "${aws_alb_target_group.ecs-service.arn}"
}

output "ecs_private_namespace_id" {
   value = "${aws_service_discovery_private_dns_namespace.ecs-namespace.id}"
}
