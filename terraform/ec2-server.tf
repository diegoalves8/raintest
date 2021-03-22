# EC2 JUMP SERVER FOR RDS

resource "aws_instance" "jumpserver" {
    ami = var.ami
    instance_type = var.instance_type
    tags = {
        Name = "uscajump01"
        Description = "A jump server used to access RDS"
        Environment = "rain"
    }
    user_data = <<-EOF
        #!/bin/bash
        yum update
        echo "terraform applied" > /var/log/terraform.txt
        EOF
    key_name = aws_key_pair.jump.id
    vpc_security_group_ids = [ aws_security_group.jump-sg.id ]
    depends_on = [ aws_internet_gateway.rain-igw ]
}

resource "aws_key_pair" "jump" {
    public_key = file(var.sshkey)
}

#security groups
resource "aws_security_group" "jump-sg" {
    name = "jump-sg"
    description = "allow ssh access to our jump server"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output publicip {
    value = aws_instance.jumpserver.public_ip
}
