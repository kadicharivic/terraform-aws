resource "aws_s3_bucket" "bucket" {
  bucket = "raw-desafio-picpay"
  acl    = "private"
}

resource "aws_kinesis_firehose_delivery_stream" "delivery_stream" {
  name        = "terraform-kinesis-firehose-s3"
  destination = "s3"

  kinesis_source_configuration {
    kinesis_stream_arn = aws_kinesis_stream.kinesisStream.arn
    role_arn = aws_iam_role.picpay_role.arn
  }
  s3_configuration {
    role_arn   = aws_iam_role.picpay_role.arn
    bucket_arn = aws_s3_bucket.bucket.arn
  }
}