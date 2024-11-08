////MyEC2Server ( Name of Server ) Amazon Linux AMI 2 -> T2.Micro 
/// AMI 

resource "aws_instance" "MyEC2ServerAYY" {
  ami                  = "ami-04a790ca5ad2f097c"
  instance_type        = "t2.micro"
  subnet_id            = aws_subnet.public_subnet.id
  iam_instance_profile = data.aws_iam_role.ec2_role_ssm.name
  depends_on           = [aws_subnet.public_subnet]
}