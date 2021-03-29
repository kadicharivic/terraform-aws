resource "aws_kinesis_firehose_delivery_stream" "extended_s3_stream" {
  name        = "terraform-kinesis-firehose-extended-s3"
  destination = "extended_s3"
  
  kinesis_source_configuration {
    kinesis_stream_arn = aws_kinesis_stream.kinesisStream.arn
    role_arn = aws_iam_role.picpay_role.arn
  }
  extended_s3_configuration {
    buffer_size = 64
    role_arn   = aws_iam_role.picpay_role.arn
    bucket_arn = aws_s3_bucket.bucket_clean.arn

    # ... other configuration ...
    data_format_conversion_configuration {
      input_format_configuration {
        deserializer {
          open_x_json_ser_de {}
        }
      }

      output_format_configuration {
        serializer {
          parquet_ser_de {}
        }
      }

      schema_configuration {
        database_name = aws_glue_catalog_database.aws_glue_catalog_database.name
        role_arn      = aws_iam_role.picpay_role.arn
        table_name    = aws_glue_catalog_table.aws_glue_catalog_table.name
      }
    }

    processing_configuration {
      enabled = "true"

      processors {
        type = "Lambda"

        parameters {
          parameter_name  = "LambdaArn"
          parameter_value = "${aws_lambda_function.lambda_function_2.arn}:$LATEST"
        }
      }
    }
  }
}

resource "aws_s3_bucket" "bucket_clean" {
  bucket = "cleaned-desafio-picpay"
  acl    = "private"
}

resource "aws_lambda_function" "lambda_function_2" {
  filename      = "lambda_function_2.zip"
  function_name = "firehose_lambda_processor"
  role          = aws_iam_role.picpay_role.arn
  handler       = "lambda_function_2.lambda_handler"
  runtime       = "python3.6"
  timeout       = 60
}