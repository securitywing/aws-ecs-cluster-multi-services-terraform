resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 2
  min_capacity       = 1
  #resource id format = "service/clusterName/serviceName"
  resource_id        = "service/${var.CLUSTER_NAME}/${var.APPLICATION_NAME}"
  role_arn           = "${aws_iam_role.ecs_auto_scaling_role.arn}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  depends_on         = [ aws_ecs_service.ecs-service]
}

# CPU Scaling Policy
resource "aws_appautoscaling_policy" "ecs_cpu_policy" {
  name               = "${var.APPLICATION_NAME}-cpu-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = "${aws_appautoscaling_target.ecs_target.resource_id}"
  scalable_dimension = "${aws_appautoscaling_target.ecs_target.scalable_dimension}"
  service_namespace  = "${aws_appautoscaling_target.ecs_target.service_namespace}"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = 65
    scale_in_cooldown  = 60
    scale_out_cooldown = 60
  }

}

# Memory Scaling Policy
resource "aws_appautoscaling_policy" "ecs_memory_policy" {
  name               = "${var.APPLICATION_NAME}-memory-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = "${aws_appautoscaling_target.ecs_target.resource_id}"
  scalable_dimension = "${aws_appautoscaling_target.ecs_target.scalable_dimension}"
  service_namespace  = "${aws_appautoscaling_target.ecs_target.service_namespace}"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = 80
    scale_in_cooldown  = 60
    scale_out_cooldown = 60
  }

}

