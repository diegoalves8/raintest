########### RAIN VPC
resource "aws_vpc" "rain" {
  cidr_block       = var.networkvpccidr
  enable_dns_hostnames = "true"


  tags = {
    Name = "VPC rain"
    Description = "A VPC for rain environment"
    Environment = "rain"
  }
}

######### RAIN SUBNET
resource "aws_subnet" "rain-private-subnet" {
  vpc_id     = aws_vpc.rain.id
  cidr_block = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  count = length(var.private_subnets)

  tags = {
    Name = "Main"
    Description = "A private subnet for rain environment"
    Environment = "rain"
  }
}

resource "aws_subnet" "rain-public-subnet" {
  vpc_id     = aws_vpc.rain.id
  cidr_block = element(var.public_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  count = length(var.public_subnets)
  map_public_ip_on_launch = true

  tags = {
    Name = "Main"
    Description = "A public subnet for rain environment"
    Environment = "rain"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.rain.id
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  count             = length(var.private_subnets)
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.rain.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  count                   = length(var.public_subnets)
  map_public_ip_on_launch = true
}

### RAIN IGW
resource "aws_internet_gateway" "rain-igw" {
  vpc_id = aws_vpc.rain.id

  tags = {
    Name = "rain-igw"
    Description = "Rain internet gateway"
    Environment = "rain"
  }
}

#### RAIN PUBLIC ROUTE TABLE
resource "aws_route_table" "public-rain-rtb" {
  vpc_id = aws_vpc.rain.id
}

  resource "aws_route" "public-rain-rtb" {
      route_table_id = aws_route_table.public-rain-rtb.id
      destination_cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.rain-igw.id
}

resource "aws_route_table_association" "public-rain-rtb" {
    count = length(var.public_subnets)
    subnet_id = element(aws_subnet.public.*.id, count.index)
    route_table_id = aws_route_table.public-rain-rtb.id
}



####### RAIN NGW
resource "aws_nat_gateway" "rain" {
    count = length(var.private_subnets)
    allocation_id = element(aws_eip.nat.*.id, count.index)
    subnet_id = element(aws_subnet.private.*.id, count.index)
    depends_on = [aws_internet_gateway.rain-igw]
}
 
resource "aws_eip" "nat" {
    count = length(var.private_subnets)
    vpc = true
}

resource "aws_route_table" "private-rain-rtb" {
    count = length(var.private_subnets)
    vpc_id = aws_vpc.rain.id
}
 
resource "aws_route" "private-rain-rtb" {
    count = length(compact(var.private_subnets))
    route_table_id = element(aws_route_table.private-rain-rtb.*.id, count.index)
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.rain.*.id, count.index)
}
 
resource "aws_route_table_association" "private" {
    count = length(var.private_subnets)
    subnet_id = element(aws_subnet.rain-private-subnet.*.id, count.index)
    route_table_id = element(aws_route_table.private-rain-rtb.*.id, count.index)
}

############## ALB
resource "aws_lb" "rain" {
    name = "rain-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = ["rain-alb-sg"]
    subnets = var.public_subnets
  enable_deletion_protection = false
}
 
resource "aws_alb_target_group" "rain" {
    name = "rain"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
    target_type = "ip"
    
    health_check {
        healthy_threshold = "3"
        interval = "30"
        protocol = "HTTP"
        matcher = "200"
        timeout = "3"
        path = var.health_check_path
        unhealthy_threshold = "2"
  }
}

resource "aws_alb_listener" "http" {
    load_balancer_arn = aws_lb.rain.id
    port = 8081
    protocol = "HTTP"
    default_action {
        type = "forward"
        target_group_arn = aws_alb_target_group.rain.arn
        }
    }

output "aws_alb_target_group_arn" {
  value = aws_alb_target_group.rain.arn
}

########## ASG
resource "aws_appautoscaling_target" "ecs_rain_tg" {
    max_capacity = 2
    min_capacity = 1
    resource_id = "service/${aws_ecs_cluster.rain.name}/${aws_ecs_service.microservice1.name}"
    scalable_dimension = "ecs:service:DesiredCount"
    service_namespace  = "ecs"
}

resource "aws_ecs_service" "microservice1" {
    name = "microservice1"
    cluster = aws_ecs_cluster.rain.id
    task_definition = aws_ecs_task_definition.microservice1.arn
    desired_count = 1
    deployment_minimum_healthy_percent = 100
    deployment_maximum_percent = 200
    launch_type = "FARGATE"
    scheduling_strategy = "REPLICA"
    depends_on = [aws_alb_listener.rain]
    

network_configuration {
    security_groups  = var.ecs_service_security_groups
    subnets = var.public_subnets
    assign_public_ip = true
}

load_balancer {
    target_group_arn = var.aws_alb_target_group_arn
    container_name = "microservice1"
    container_port = var.task_port_micro1
   
}

lifecycle {
    ignore_changes = [task_definition, desired_count]
}
}