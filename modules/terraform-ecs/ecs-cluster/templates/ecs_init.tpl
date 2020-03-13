#!/bin/bash
echo 'ECS_CLUSTER=${CLUSTER_NAME}' > /etc/ecs/ecs.config
echo "ECS_AVAILABLE_LOGGING_DRIVERS=[\"awslogs\",\"fluentd\"]" >> /etc/ecs/ecs.config
start ecs
