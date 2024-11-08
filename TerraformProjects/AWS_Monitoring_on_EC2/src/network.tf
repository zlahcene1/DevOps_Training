//Déclaration du VPC 

resource "aws_vpc" "my_vpc" {
  cidr_block = var.ip_vpc

  tags = {
    Name = "my_vpc"
  }
}

//Déclartion du Subnet Public

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.ip_subnet
  map_public_ip_on_launch = true # Attribue automatiquement une IP publique aux instances
}

//Déclaration de Gateway Internet 

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id

}

//Déclaration de la RouteTable

resource "aws_route_table" "public_rt" {
  vpc_id     = aws_vpc.my_vpc.id
  depends_on = [aws_internet_gateway.gw]

  route {
    cidr_block = var.ip_all
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
  depends_on     = [aws_route_table.public_rt]
}
