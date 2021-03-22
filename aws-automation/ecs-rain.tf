############# ECS CLUSTER
resource "aws_ecs_cluster" "rain" {
    name = "rainus"
}


############## ECS TASKS
resource "aws_ecs_task_definition" "microservice1" {
    family = "service"
    network_mode = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu = 256
    memory = 512
    execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
    task_role_arn = aws_iam_role.ecs_task_role.arn
    container_definitions = jsonencode([{
        name = "microservice1"
        image = "${var.container_image_microservice1}:latest"
        essential = true
#        environment = prod
        portMappings = [{
            protocol = "tcp"
            containerPort = var.container_port
            hostPort = var.task_port_micro1
   }]
    }])
}

########### ECS SERVICES


############## IAM ROLE
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "rain-ecsTaskExecutionRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role" "ecs_task_role" {
  name = "rain-ecsTaskRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}