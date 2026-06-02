terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "madworld" {
  bucket = var.bucket
}

resource "aws_s3_bucket_acl" "madworld" {
  bucket     = aws_s3_bucket.madworld.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.madworld]
}

resource "aws_s3_bucket_ownership_controls" "madworld" {
  bucket = aws_s3_bucket.madworld.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "madworld" {
  bucket              = aws_s3_bucket.madworld.id
  block_public_acls   = false
  block_public_policy = false
}

resource "aws_s3_bucket_cors_configuration" "madworld" {
  bucket = aws_s3_bucket.madworld.id
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = var.allowed_origins
    expose_headers = [
      "Content-Length",
      "Content-Type",
      "ETag"
    ]
    max_age_seconds = 3000
  }
}

resource "aws_s3_object" "madworld-extras" {
  for_each    = fileset("../extras/", "**")
  acl         = "public-read"
  bucket      = aws_s3_bucket.madworld.id
  key         = "extras/${each.value}"
  source      = "../extras/${each.value}"
  source_hash = filemd5("../extras/${each.value}")
  depends_on  = [aws_s3_bucket_ownership_controls.madworld, aws_s3_bucket_public_access_block.madworld]
}

resource "aws_s3_object" "madworld-samples" {
  for_each    = fileset("../samples/", "**")
  acl         = "public-read"
  bucket      = aws_s3_bucket.madworld.id
  key         = "samples/${each.value}"
  source      = "../samples/${each.value}"
  source_hash = filemd5("../samples/${each.value}")
  depends_on  = [aws_s3_bucket_ownership_controls.madworld, aws_s3_bucket_public_access_block.madworld]
}

resource "aws_s3_object" "madworld-tracks" {
  for_each    = fileset("../tracks/", "**")
  acl         = "public-read"
  bucket      = aws_s3_bucket.madworld.id
  key         = "tracks/${each.value}"
  source      = "../tracks/${each.value}"
  source_hash = filemd5("../tracks/${each.value}")
  depends_on  = [aws_s3_bucket_ownership_controls.madworld, aws_s3_bucket_public_access_block.madworld]
}

resource "aws_s3_object" "madworld-videos" {
  for_each    = fileset("../videos/", "**")
  acl         = "public-read"
  bucket      = aws_s3_bucket.madworld.id
  key         = "videos/${each.value}"
  source      = "../videos/${each.value}"
  source_hash = filemd5("../videos/${each.value}")
  depends_on  = [aws_s3_bucket_ownership_controls.madworld, aws_s3_bucket_public_access_block.madworld]
}
