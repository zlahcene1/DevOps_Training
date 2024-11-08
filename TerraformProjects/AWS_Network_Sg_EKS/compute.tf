resource "aws_instance" "instance-ec2" {
  ami = data.aws_ami.latest_amazon_linux.id
  //ami             = "ami-04f76ebf53292ef4d"
  instance_type   = var.instance_type
  security_groups = [aws_security_group.ssh_http_https.id]
  subnet_id       = aws_subnet.public[0].id
  depends_on      = [aws_security_group.ssh_http_https, aws_subnet.public[0]]
}