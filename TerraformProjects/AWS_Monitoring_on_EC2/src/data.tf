data "aws_iam_role" "ec2_role_ssm" {
  name = "esgi_EC2_Role"
}

data "aws_iam_role" "role_cloudwatch_cloudtrail" {
  name = "role_cloudwatch_cloudtrail"
}

data "aws_caller_identity" "current" {}