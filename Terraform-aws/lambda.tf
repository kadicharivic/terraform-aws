resource "aws_cloudwatch_event_rule" "cloudwatch_event" {
  name = "cloudwatch"
  schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "cloudwatch_target" {
  rule = aws_cloudwatch_event_rule.cloudwatch_event.name
  arn = aws_lambda_function.lambda_function.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cloudwatch_event.arn
}

resource "aws_lambda_function" "lambda_function" {
  filename      = "lambda_function.zip"
  function_name = "api_lambda_processor"
  role          = aws_iam_role.picpay_role.arn
  handler       = "lambda_function.lambda_handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("lambda_function.zip")

  runtime = "python3.6"

}
