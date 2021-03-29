resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  name = "data_base_glue"
}

resource "aws_glue_catalog_table" "aws_glue_catalog_table" {
  name          = "data_clean_picpay"
  database_name = "data_base_glue"

  table_type = "EXTERNAL_TABLE"

  parameters = {
    EXTERNAL              = "TRUE"
    "parquet.compression" = "UNCOMPRESSED"
  }

  storage_descriptor {
    location      = "s3://cleaned-desafio-picpay/success"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      name                  = "data_clean.csv"
      serialization_library = "org.apache.hadoop.hive.serde2.OpenCSVSerde"

      parameters = {
        "serialization.format" = 1
      }
    }

    columns {
      name = "id"
      type = "string"
    }

    columns {
      name = "name"
      type = "string"
    }

    columns {
      name    = "abv"
      type    = "string"
    }

    columns {
      name    = "ibu"
      type    = "string"
    }

    columns {
      name    = "target_fg"
      type    = "string"
    }

    columns {
      name    = "target_og"
      type    = "string"
    }

    columns {
      name    = "ebc"
      type    = "string"
    }

    columns {
      name    = "srm"
      type    = "string"
    }

    columns {
      name    = "ph"
      type    = "string"
    }

  }
}