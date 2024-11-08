# SNS Topic
resource "aws_sns_topic" "sns_topic" {
  name = "MyServerMonitor"
}

# SNS Subscription with Email Endpoint
resource "aws_sns_topic_subscription" "sns_email" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint  = var.mail
}

resource "aws_sns_topic_policy" "sns_topic_policy" {
  arn = aws_sns_topic.sns_topic.arn
  policy = jsonencode({
    Version = "2008-10-17",
    Id      = "__default_policy_ID",
    Statement = [
      {
        Sid       = "__default_statement_ID",
        Effect    = "Allow",
        Principal = { "AWS" : "*" },
        Action = [
          "SNS:GetTopicAttributes",
          "SNS:SetTopicAttributes",
          "SNS:AddPermission",
          "SNS:RemovePermission",
          "SNS:DeleteTopic",
          "SNS:Subscribe",
          "SNS:ListSubscriptionsByTopic",
          "SNS:Publish"
        ],
        Resource = aws_sns_topic.sns_topic.arn,
        Condition = {
          StringEquals = {
            "AWS:SourceOwner" = data.aws_caller_identity.current.account_id
          }
        }
      },
      {
        Sid       = "AllowEventBridgeToPublish",
        Effect    = "Allow",
        Principal = { Service = "events.amazonaws.com" },
        Action    = "sns:Publish",
        Resource  = aws_sns_topic.sns_topic.arn
      }
    ]
  })
}
