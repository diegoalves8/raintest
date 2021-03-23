
############## AWS ACCESS
variable "aws-access" {
  default = ""
}

variable "aws-secret" {
  default = ""
}
############# END AWS ACCESS

############# AWS REGION / AZ
variable "region" {
  default = "us-east-2"
}

variable "availability_zones" {
  default = ["us-east-2a", "us-east-2b"]
}

############ END AWS REGION / AZ

############ RAIN NETWORK
variable "networkvpccidr" {
  default = "10.255.0.0/16"
}

variable "private_subnets" {
  description = "Rain private subnets"
  default     = ["10.255.161.0/24", "10.255.162.0/24"]
}

variable "public_subnets" {
  description = "Rain public subnets"
  default     = ["10.255.172.0/24", "10.255.173.0/24"]
}

variable "vpc_id" {
  description = "vpc name"
  default     = "rain"
}

########### END RAIN NETWORK


########### ALB
variable "health_check_path" {
  description = "Http path for task health check"
  default     = "/"
}
variable "subnets" {
  description = "Comma separated list of subnet IDs"
  default     = ["10.255.151.0/24", "10.255.150.0/24"]
}

######### container image
variable "container_image_microservice1" {
  description = "microservices2"
  default     = "vander/rainus-micro1"
}
variable "container_image_microservice2" {
  description = "microservices2"
  default     = "vander/rainus-micro2"
}

variable "container_image_webpage" {
  description = "webpage"
  default     = "vander/rainus-httpd"
}
variable "container_image_api" {
  description = "rain api"
  default     = "vander/rainus"
}

#########   ECS
variable "aws_alb_target_group_arn" {
  description = "ARN ALB TG"
  default     = "aws_alb_target_group.rain.arn"
  #default = "ecs_rain_tg"
  #default = "null"
}

variable "ecs_service_security_groups" {
  default = ["rain-ecs-sg"]
}

variable "task_port_api" {
  description = "the microservice port"
  default     = 8080
}

variable "task_port_webpage" {
  description = "the microservice port"
  default     = 80
}
variable "container_port" {
  description = "container port"
  default     = 80
}

variable "task_port_micro1" {
  description = "the microservice port"
  default     = 80
}
variable "task_port_micro2" {
  description = "the microservice port"
  default     = 80
}
variable "task_port_micro3" {
  description = "the microservice port"
  default     = 80
}
variable "task_port_micro4" {
  description = "the microservice port"
  default     = 80
}
variable "task_port_micro5" {
  description = "the microservice port"
  default     = 80
}
variable "task_port_micro6" {
  description = "the microservice port"
  default     = 80
}
variable "task_port_micro7" {
  description = "the microservice port"
  default     = 80
}
variable "task_port_micro8" {
  description = "the microservice port"
  default     = 80
}

########### END ALB / ECS

############# RAIN EC2 RESOURCES
variable "ami" {
  default     = "ami-089c6f2e3866f0f14"
  type        = string
  description = "AMI Amazon Linux 2 used for the jump server"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "Instance type being used for the jump server, there is no need to have more than a t2.micro"
}

variable "sshkey" {
  default     = "/root/.ssh/id_rsa.pub"
  description = "use your public key here"
}

################### EC2 RESOURCES END

#RDS RESOURCES START
variable "rdsdb" {
  default = "rainusdb"
}


#################### RDS RESOURCES END
variable "filename" {
  default = "myfile.txt"
}

variable "content" {
  default = "my content is this"
}
