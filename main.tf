provider "aws" {
  region = "eu-north-1"
}

# Fetch the latest Amazon Linux 2023 AMI dynamically
data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

# VPC
resource "aws_vpc" "python_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name    = "python-project-vpc"
    Project = "python-project"
  }
}

# Internet Gateway, Subnet, Route Table
resource "aws_internet_gateway" "python_igw" {
  vpc_id = aws_vpc.python_vpc.id
  tags = { Name = "python-project-igw", Project = "python-project" }
}

resource "aws_subnet" "python_subnet" {
  vpc_id                  = aws_vpc.python_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = true
  tags = { Name = "python-project-subnet", Project = "python-project" }
}

resource "aws_route_table" "python_rt" {
  vpc_id = aws_vpc.python_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.python_igw.id
  }
  tags = { Name = "python-project-rt", Project = "python-project" }
}

resource "aws_route_table_association" "python_rta" {
  subnet_id      = aws_subnet.python_subnet.id
  route_table_id = aws_route_table.python_rt.id
}

# Security Group
resource "aws_security_group" "python_sg" {
  name        = "python-project-sg"
  description = "Allow SSH and app ports"
  vpc_id      = aws_vpc.python_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "App 5000"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "App 9000"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "App 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "python-project-sg", Project = "python-project" }
}

# Variables
variable "instance_type" {
  default = "t3.small"
}

# EC2 Instances
resource "aws_instance" "jenkins" {
  ami                         = data.aws_ssm_parameter.al2023.value
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.python_subnet.id
  vpc_security_group_ids      = [aws_security_group.python_sg.id]
  associate_public_ip_address = true
  key_name                    = "peter-aws"
  tags = { Name = "jenkins", Project = "python-project" }
}

resource "aws_instance" "docker" {
  ami                         = data.aws_ssm_parameter.al2023.value
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.python_subnet.id
  vpc_security_group_ids      = [aws_security_group.python_sg.id]
  associate_public_ip_address = true
  key_name                    = "peter-aws"
  tags = { Name = "docker", Project = "python-project" }
}

resource "aws_instance" "kubernetes" {
  ami                         = data.aws_ssm_parameter.al2023.value
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.python_subnet.id
  vpc_security_group_ids      = [aws_security_group.python_sg.id]
  associate_public_ip_address = true
  key_name                    = "peter-aws"
  tags = { Name = "kubernetes", Project = "python-project" }
}

