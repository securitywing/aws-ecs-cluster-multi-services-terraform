resource "aws_service_discovery_private_dns_namespace" "ecs-namespace" {
  name        = "ecs"
  description = "private dns namespace"
  vpc          = "${var.VPC_ID}"
}

resource "aws_service_discovery_service" "ecs-service-discovery" {
  name = "${var.APPLICATION_NAME}"

  dns_config {
    namespace_id = "${aws_service_discovery_private_dns_namespace.ecs-namespace.id}"

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}#

