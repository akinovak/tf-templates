provider "cloudflare" { 
  email    = var.cloudflare_email
  api_key  = var.cloudflare_key
}

data "cloudflare_zones" "domain" {
  filter {
    name = var.site_domain
  }
}

resource "cloudflare_page_rule" "ssl" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  target  = "${var.subdomain}.${var.site_domain}/*"
  actions {
    ssl = "flexible"
  }
}


resource "cloudflare_record" "site_cname" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = var.subdomain
  value   = aws_s3_bucket.site.website_endpoint
  type    = "CNAME"

  ttl     = 1
  proxied = true
}


resource "cloudflare_record" "www" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = "www.${var.subdomain}"
  value   = aws_s3_bucket.www.website_endpoint
  type    = "CNAME"

  ttl     = 1
  proxied = true
}