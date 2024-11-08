resource "aws_vpc" "vpcayy" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "vpcayy"
  }
}

resource "aws_subnet" "private" {
  count             = 3
  vpc_id            = aws_vpc.vpcayy.id
  cidr_block        = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"][count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "sub-${data.aws_availability_zones.available.names[count.index]}-priv"
  }
  depends_on = [aws_vpc.vpcayy]
}

resource "aws_subnet" "public" {
  count                   = 3
  vpc_id                  = aws_vpc.vpcayy.id
  cidr_block              = ["10.1.4.0/24", "10.1.5.0/24", "10.1.6.0/24"][count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "sub-${data.aws_availability_zones.available.names[count.index]}-pub"
  }
  depends_on = [aws_vpc.vpcayy]
}

resource "aws_internet_gateway" "wan-ayy-gateway" {
  vpc_id = aws_vpc.vpcayy.id

  tags = {
    Name = "wan-ayy-gateway"
  }
  depends_on = [aws_vpc.vpcayy]
}

resource "aws_route_table" "route_table_wan" {
  vpc_id = aws_vpc.vpcayy.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wan-ayy-gateway.id
  }

  tags = {
    Name = "route_table_wan"
  }
  depends_on = [aws_vpc.vpcayy, aws_internet_gateway.wan-ayy-gateway]
}

resource "aws_route_table_association" "public" {
  count          = 3
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.route_table_wan.id
  depends_on     = [aws_route_table.route_table_wan, aws_subnet.public[0], aws_subnet.public[1], aws_subnet.public[2]]
}

resource "aws_route_table" "route_table_lan" {
  vpc_id = aws_vpc.vpcayy.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-ayy-gateway.id
  }
  tags = {
    Name = "route_table_lan"
  }
  depends_on = [aws_vpc.vpcayy, aws_nat_gateway.nat-ayy-gateway]
}

resource "aws_route_table_association" "private" {
  count          = 3
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.route_table_lan.id
  depends_on     = [aws_route_table.route_table_lan, aws_subnet.private[0], aws_subnet.private[1], aws_subnet.private[3]]
}

resource "aws_eip" "epi" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat-ayy-gateway" {
  allocation_id = aws_eip.epi.id
  subnet_id     = aws_subnet.private[0].id
  tags = {
    Name = "nat-ayy-gw"
  }
  depends_on = [aws_eip.epi, aws_subnet.private[0]]
}