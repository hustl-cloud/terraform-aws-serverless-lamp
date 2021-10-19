# create lambda execution role
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}


# "PolicyDocument": {
#               "Version": "2012-10-17",
#               "Statement": [
#                 {
#                   "Effect": "Allow",
#                   "Action": [
#                     "logs:CreateLogStream",
#                     "logs:CreateLogGroup"
#                   ],
#                   "Resource": [
#                     {
#                       "Fn::Sub": "arn:${AWS::Partition}:logs:${AWS::Region}:${AWS::AccountId}:log-group:/aws/lambda/laravel-dev*:*"
#                     }
#                   ]
#                 },
#                 {
#                   "Effect": "Allow",
#                   "Action": [
#                     "logs:PutLogEvents"
#                   ],
#                   "Resource": [
#                     {
#                       "Fn::Sub": "arn:${AWS::Partition}:logs:${AWS::Region}:${AWS::AccountId}:log-group:/aws/lambda/laravel-dev*:*:*"
#                     }
#                   ]
#                 }
#               ]
#             }