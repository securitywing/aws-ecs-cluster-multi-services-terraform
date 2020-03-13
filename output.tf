output "alb-dns-url" {
  value = "${module.tf-alb.dns_name}"
}


output "ecs_namespace_id" {
  value = "${module.tf-service.ecs_private_namespace_id}"
}

