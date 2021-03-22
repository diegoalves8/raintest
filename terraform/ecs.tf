resource "aws_ecs_cluster" "rain-cluster" {
  name = "rain-cluster"
    tags = {
        Name = "rain-cluster"
        Description = "ECS Cluster"
        Environment = "rain"
    }
}

resource "aws_ecs_task_definition" "microservice1" {
  family = "microservice1"
  container_definitions = jsonencode([
    {
      name      = "first"
      requires_compatibilities = FARGATE
      image     = "service-first"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    },
  ])
  }
