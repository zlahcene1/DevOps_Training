
# CloudWatch Event Rule to monitor EC2 instance state changes
resource "aws_cloudwatch_event_rule" "ec2_state_change" {
  name        = "MyEC2StateChangeEvent"
  description = "Trigger SNS notification on EC2 instance state change"
  event_pattern = jsonencode({
    "source" : ["aws.ec2"],
    "detail-type" : ["EC2 Instance State-change Notification"],
    "detail" : {
      "instance-id" : [aws_instance.MyEC2ServerAYY.id]
    }
  })
}

# CloudWatch Event Target pointing to SNS Topic
resource "aws_cloudwatch_event_target" "sns_target" {
  rule      = aws_cloudwatch_event_rule.ec2_state_change.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.sns_topic.arn
}