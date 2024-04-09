# Define provider (AWS)
provider "aws" {
  region = "us-east-1"  # Specify your desired AWS region
}

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"  # Specify your desired CIDR block
  tags={
        Name = "TerraformVPC"
  }
}

# Create a public subnet within the VPC
resource "aws_subnet" "public_sub" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"  # Specify your desired CIDR block
 
}
# Create a public subnet within the VPC
resource "aws_subnet" "private_sub" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"  # Specify your desired CIDR block
  
}

# Create an internet gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

# Create a route table
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

# Associate the route table with the public subnet
resource "aws_route_table_association" "my_subnet_association" {
  subnet_id      = aws_subnet.public_sub.id
  route_table_id = aws_route_table.my_route_table.id
}
