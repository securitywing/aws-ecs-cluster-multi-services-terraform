resource "aws_service_discovery_service" "ecs-service-discovery" {
  name = "${var.APPLICATION_NAME}"

  dns_config {
    namespace_id  = "${var.NAME_SPACE_ID}"
    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

