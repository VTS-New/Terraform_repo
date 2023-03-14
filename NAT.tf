#Define External IP
resource "aws_eip" "level-nat" {
  vpc = true
}

resource "aws_nat_gateway" "levelup-nat-gw" {
    allocation_id   = aws_eip.levelup-nat.id
    subnet_id       = aws_subnet.levelupvpc-public-1.id
    depends_on      =  [aws_internet_gateway.levelup-gw]
}

resource "aws_route_table" "levelup-private" {
    vpc_id          = "aws_vpc.levelup.id"
    route {
        cidr_block  = "0.0.0.0/0"
        nat_gateway_id  = aws_nat_gateway.levelup-nat-gw.id
    }
    tags    = {
      Name  = "levelup-private"
    }
  }

# Route associations private
resource "aws_route_table_association" "level-private-1-a" {
  subnet_id         = aws_subnet.levelupvpc-private-1.vpc_id
  route_table_id    = aws_route_table.levelup-private.id
}

resource "aws_route_table_association" "level-private-2-a" {
  subnet_id         = aws_subnet.levelupvpc-priavte-2.vpc_id
  route_table_id    = aws_route_table.levelup-private.id  
}

resource "aws_route_table_association" "level-private-3-a" {
    subnet_id       = aws_subnet.levelupvpc-private-3.vpc_id
    route-table_id  = aws_route_table.levelup-priavte.id
}