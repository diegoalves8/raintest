############# ECS CLUSTER
resource "aws_ecs_cluster" "rainus" {
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
resource "aws_ecs_service" "microservice1" {
    name = "microservice1"
    cluster = aws_ecs_cluster.rainus.id
    task_definition = aws_ecs_task_definition.microservice1.arn
    desired_count = 1
    deployment_minimum_healthy_percent = 100
    deployment_maximum_percent = 200
    launch_type = "FARGATE"
    scheduling_strategy = "REPLICA"
    depends_on = [aws_alb_listener.http]
    

network_configuration {
    security_groups  = [aws_security_group.rain-ecs-sg.id]
    subnets = aws_subnet.public.*.id
    assign_public_ip = true
}

load_balancer {
    target_group_arn = aws_alb_target_group.rain.arn
    container_name = "microservice1"
    container_port = var.task_port_micro1
}

lifecycle {
    ignore_changes = [task_definition, desired_count]
}
}

############## IAM ROLE
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "RainecsTaskExecutionRole"

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

resource "aws_iam_role" "ecs_task_role" {
  name = "RainecsTaskRole"

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

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

