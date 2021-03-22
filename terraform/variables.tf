# EC2 RESOURCES
variable "ami" {
    default = "ami-089c6f2e3866f0f14"
    type = string
    description = "AMI Amazon Linux 2 used for the jump server"
}

variable "instance_type" {
    default = "t2.micro"
    description = "Instance type being used for the jump server, there is no need to have more than a t2.micro"
}

variable "sshkey" {
    default = "/root/.ssh/id_rsa.pub"
    description = "use your public key here"
}

################### EC2 RESOURCES END






#VPC RESOURCES START
variable "networkvpc" {
    default = "10.255.0.0/16"
}

#################### VPC RESOURCES END




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