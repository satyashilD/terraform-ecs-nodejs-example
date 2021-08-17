resource "aws_ecs_service" "my_first_service" {
  name            = var.service_name
  cluster         = var.ecs_cluster_id
  task_definition = var.ecs_task_arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = var.subnets
    assign_public_ip = true
  }
}

variable ecs_cluster_id {}
variable ecs_task_arn {}
variable subnets {}
variable service_name {}