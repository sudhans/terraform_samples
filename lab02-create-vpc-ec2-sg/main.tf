provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "msd_demo_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "MSD-Terraform-VPC"
  }
}

resource "aws_internet_gateway" "msd_internet_gateway" {
  vpc_id = aws_vpc.msd_demo_vpc.id

  tags = {
    Name = "MSD-Terraform-IGW"
  }
}

resource "aws_subnet" "msd_public_subnet" {
  vpc_id                  = aws_vpc.msd_demo_vpc.id
   cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "MSD-Terraform-Public-Subnet"
  }
}

# resource "aws_route_table" "msd-public-route-table" {
#   vpc_id = aws_vpc.msd_demo_vpc.id

#   route = {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.msd_internet_gateway.id
#   }


#   tags = {
#     Name = "MSD-Terraform-Public-Route-Table"
#   }
# }

# resource "aws_route_table_association" "msd_public_route_table_association" {
#   subnet_id      = aws_subnet.msd_public_subnet.id
#   route_table_id = aws_route_table.msd-public-route-table.id

# }

resource "aws_instance" "msd_ec2_t3_micro" {
  ami           = "ami-02b49a24cfb95941c" #Amazon Linux x86-64
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.msd_public_subnet.id

  tags = {
    Name = "MSD-Terraform-Lab02"
  }

}