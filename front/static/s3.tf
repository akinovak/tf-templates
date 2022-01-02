resource "aws_s3_bucket" "site" {
  bucket = var.subdomain != "" ? "${var.subdomain}.${var.site_domain}" : "${var.site_domain}"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}

resource "aws_s3_bucket" "www" {
  bucket = "www.${var.subdomain != "" ? "${var.subdomain}.${var.site_domain}" : "${var.site_domain}"}"
  acl    = "public-read"
  policy = ""

  website {
    redirect_all_requests_to = "https://${var.subdomain != "" ? "${var.subdomain}.${var.site_domain}" : "${var.site_domain}"}"
  }
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.site.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.site.arn,
          "${aws_s3_bucket.site.arn}/*",
        ],
      },
    ]
  })
}
