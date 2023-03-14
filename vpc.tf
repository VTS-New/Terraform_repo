# Create AWS VPC
resource "aws_vpc" "levelupvpc"
cidr_block         = "10.0.0.0/16"
instance_tenancy   = "default"
enable_dns_support   = "true"
enable_dns_hostnames = "true"
enable_classiclink   = "false"

tags = {
    Name = "levelupvpc"
}

# Public Subnets in Custom VPC
resource "aws_subnet" "levelupvpc-public-1" {
    vpc_id              = "aws_vpc.levelupvpc.id"
    cidr_block          = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone       = "us-east-2a"

    tags = {
        Name = "levelupvpc-public-1"
    }
}

resource "aws_subnet" "levelupvpc_public-2" {
    vpc_id                 = "aws_vpc.levelupvpc.id"
    cidr_block             = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone       = "us-east-2b"

    tags = {
      Name = "levelupvpc_public-2"
    }
}

resource "aws_subbet" "levelupvpc_public-3" {
    vpc_id                  = "aws_vpc.levelupvpc.id"
    cidr_block              = "10.0.3.0/24"
    map_public_ip_on_lanuch = "true"
    availability_zone       = "us-east-2c"

    tags = {
        Name = "levelupvpc_public-3"
    }
}

# Private Subnet in Custom VPC

resource "aws_vpc" "levelupvpc-private-1" {
     vpc_id               = "aws_vpc_levelupvpc.id"
     cipv6_cidr_block     = "10.0.4.0/24"
     map_public_ip_on_launch = "false"
     availability_zone       = "us-east-2a"

     tags = {
        Name= "levelupvpc_private-1"
     } 
}

resource "aws_vpc" "levelupvpc-private-2" {
    vpc_id                 = "aws_vpc_levelupvpc.id"
    cidr_block             = "10.0.5.0/24"
    map_public_ip_on_launch = "false"
    availability_zone       = "us-east-2b"

    tags = {
        Name = "levelupvpc_private-2"
    }
}

resource "aws_vpc" "levelupvpc_private"{
    vpc_id                 = "aws_vpc.levelupvpc.id"
    cidr_block             = "10.0.6.0/24"
    map_public_ip_on_launch = "false"
    availability_zone       = "us-east-2c"

    tags = {
        Name = "levelupvpc_private-3"
    }
}   

# Custom Internet Gateway
resource "aws_internet_gateway" "levelup-gw" {
    vpc_id          = "aws_vpc.levelupvc.id"

    tags = {
        Name = "levelup-gw"
    }
}

# Routing Table for the custom VPC
resource "aws_route_table" "levelupvpc-public" {
    vpc_id = "aws_vpc.levelupvpc.id"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.levelup-gw.id
        }

    tags = {
        Name = "levelupvpc_public-1"
    }
}

resource "aws_route_table" "levelupvpc-public" {
    vpc_id = "aws_vpc.levelupvpc.id"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.levelup-gw.id
    }

    tags = {
        Name = "levelupvpc_public-2"
    }
}

resource "aws_route_table" "levelupvpc-public" {
  vpc_id = "aws.vpc.levelupvpc.id"
  route {
     cidr_block ="0.0.0.0/0"
     gateway_id = aws_internet_gateway.levelup-gw.id
  }
   tags = {
    Name = "levelupvpc_public-3"
   }
}

# Routing association 

resource "aws-route-table-association" "levelup-public-1-a" {
    subnet_id       = aws_subnet.levelupvpc-public-1.id
    route_table_id  = aws_route_table.levelup-public.id 
}

resource "aws-route-table-association" "levelup-public-2-a" {
    subnet_id       =  aws_subnet.levelupvpc-public-2.id
    route_table_id  =  aws_route_table.levelupvpc-public.id
}

resource "aws-route-table-association" "levelupvpc-public-3-a" {
    subnet_id       = aws_subnet.levelupvpc-public-3.id
    route_table_id  = aws_route_table.levelupvpc-public.id
}