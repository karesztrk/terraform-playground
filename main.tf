provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket

  tags = {
    "Project" = "CompReg Playground"
  }
}

resource "aws_s3_object" "object" {
  bucket   = aws_s3_bucket.bucket.id
  for_each = fileset("uploads/", "*")
  key      = each.value
  source   = "uploads/${each.value}"

  depends_on = [
    aws_s3_bucket.bucket
  ]
}

