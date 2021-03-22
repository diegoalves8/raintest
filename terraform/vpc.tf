########### RAIN VPC
resource "aws_vpc" "rain" {
  cidr_block       = "10.255.0.0/16"
  enable_dns_hostnames = "true"


  tags = {
    Name = "VPC rain"
    Description = "A VPC for rain environment"
    Environment = "rain"
  }
}

######### RAIN SUBNET
resource "aws_subnet" "sub1-rain" {
  vpc_id     = aws_vpc.rain.id
  cidr_block = "10.255.140.0/24"
  availability_zone = "us-east-2b"

  tags = {
    Name = "Main"
    Description = "A subnet for rain environment"
    Environment = "rain"
  }
}

resource "aws_subnet" "sub2-rain" {
  vpc_id     = aws_vpc.rain.id
  cidr_block = "10.255.141.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "Main"
    Description = "A subnet for rain environment"
    Environment = "rain"
  }
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

#### RAIN ROUTE TABLE
resource "aws_route_table" "rain-rtb" {
  vpc_id = aws_vpc.rain.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rain-igw.id
  }
  tags = {
    Name = "Rain RTB"
    Description = "Rain route table"
    Environment = "rain"
  }
}
