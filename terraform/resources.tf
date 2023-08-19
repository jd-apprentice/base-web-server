resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "production-vpc"
  }
}

resource "aws_internet_gateway" "example_igw" {
  vpc_id = aws_vpc.example_vpc.id
  tags = {
    Name = "production-igw"
  }
}

resource "aws_eip" "example_eip" {
  vpc               = true
  network_interface = aws_network_interface.webserver.id
  depends_on        = [aws_internet_gateway.example_igw]
}

resource "aws_eip_association" "example_eip_association" {
  network_interface_id = aws_network_interface.webserver.id
  allocation_id        = aws_eip.example_eip.id
  depends_on           = [aws_eip.example_eip]
}

resource "aws_subnet" "subnet_webserver" {
  vpc_id                  = aws_vpc.example_vpc.id
  availability_zone       = var.zone
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "production-subnet-webserver"
  }
}

resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.example_vpc.id

  // For everyone to access the web server
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // To allow SSH access to the web server
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" // This means any protocol
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web_traffic"
  }
}

resource "aws_network_interface" "webserver" {
  subnet_id       = aws_subnet.subnet_webserver.id
  security_groups = [aws_security_group.allow_web.id]
}

resource "aws_instance" "example_webserver" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.zone

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.webserver.id
  }

  tags = {
    Name = "production-webserver"
  }
}

resource "aws_key_pair" "example" {
  depends_on = [aws_instance.example_webserver]
  public_key = file(var.ssh_key)
}
