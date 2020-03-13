output "ecr_repo-url" {

   value = "${aws_ecr_repository.ecs-task.repository_url}"

}
