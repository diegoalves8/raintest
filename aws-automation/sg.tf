resource "aws_security_group" "rain-alb-sg" {
    name = "rain-alb-sg"
    vpc_id = var.vpc_id
    description = "allow http access to our ALB"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {        
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "rain-ecs-sg" {
    name = "rain-ecs-sg"
    vpc_id = var.vpc_id
    description = "allow http access from our ALB to ecs cluster"
    
    ingress {
        from_port = var.task_port_api
        to_port = var.container_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = var.task_port_webpage
        to_port = var.task_port_webpage
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = var.task_port_micro1
        to_port = var.container_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = var.task_port_micro2
        to_port = var.container_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = var.task_port_micro3
        to_port = var.container_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = var.task_port_micro4
        to_port = var.container_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = var.task_port_micro5
        to_port = var.container_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = var.task_port_micro6
        to_port = var.container_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = var.task_port_micro7
        to_port = var.container_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = var.task_port_micro8
        to_port = var.container_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}