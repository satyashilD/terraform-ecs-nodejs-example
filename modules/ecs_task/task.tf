resource "aws_ecs_task_definition" "task_def" {
  family                   = "V1"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "${var.container_name}",
      "image": "${var.ecr_image}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": ${var.container_port},
          "hostPort": ${var.host_port}
        }
      ],
      "memory": ${var.container_memory},
      "cpu": ${var.container_cpu},
      "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "${aws_cloudwatch_log_group.ecs.name}",
                "awslogs-region": "${var.region}",
                "awslogs-stream-prefix": "nodeapp"
            }
        }
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"] 
  network_mode             = "awsvpc"    
  memory                   = var.container_memory         
  cpu                      = var.container_cpu
  execution_role_arn       = "${aws_iam_role.task-role.arn}"
}

resource "aws_cloudwatch_log_group" "ecs" {
  name = "nodeapp"
}



output task_arn { value = aws_ecs_task_definition.task_def.arn}



variable container_cpu {}
variable container_memory {}
variable container_name {}
variable container_port {}
variable host_port {}
variable ecr_image {}
variable region {}