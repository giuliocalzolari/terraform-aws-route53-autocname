resource "aws_cloudwatch_event_rule" "cw_rule" {
  name        = "${var.app_name}"
  description = "${var.app_name}"

  event_pattern = <<PATTERN
{
  "source": [ "aws.ec2" ],
  "detail-type": [ "EC2 Instance State-change Notification" ],
  "detail": {
    "state": [
      "running",
      "terminated"
    ]
  }
}
PATTERN
}

resource "aws_cloudwatch_event_target" "cw_rule_lambda" {
  target_id = "${aws_lambda_function.lambda_fun.handler}"
  rule = "${aws_cloudwatch_event_rule.cw_rule.name}"
  arn = "${aws_lambda_function.lambda_fun.arn}"
}

resource "aws_cloudwatch_log_group" "cwlog" {
  name = "/aws/lambda/${var.app_name}"
  retention_in_days = "${var.log_retention_days}"
}
