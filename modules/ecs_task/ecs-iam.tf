resource "aws_iam_role" "task-role" {
  name = "nodeecstaskrole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "task-exec" {
  name       = "ecs-task-role-attachment"
  roles      = [aws_iam_role.task-role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_policy_attachment" "ecs-cloudwatch" {
  name       = "ecs-task-role-attachment"
  roles      = [aws_iam_role.task-role.name]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}

resource "aws_iam_policy_attachment" "ecr-power-user" {
  name       = "ecs-task-role-attachment"
  roles      = [aws_iam_role.task-role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}
