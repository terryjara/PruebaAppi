// #VPC
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "pruebared1"
    Owner = "terry jara"
  }
}


// # subnet
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Subnetprueba1"
    Owner = "terry jara"
  }
}

// # SG
resource "aws_security_group" "allow_tls" {
  name        = "prueba1"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-07f3934bdd433b772"

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "prueba1"
    Owner = "terry jara"
  }
}


// #KMS
resource "aws_kms_key" "a" {
  description             = "Prueba1"
  deletion_window_in_days = 10
  tags = {
      Owner = "terry jara"
  }
}

// # almacenamiento S3
resource "aws_s3_bucket" "b" {
  bucket = "pruebatjc"

  tags = {
    Name        = "pruebatjc"
    Owner = "terry jara"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}

// # ECS / contenedor
resource "aws_ecs_cluster" "foo" {
  name = "prueba1"

  setting {
    name  = "containerInsights"
    value = "enabled"
    
  }
}