resource "aws_route53_zone" "primary" {
  name = var.domain_name
}

resource "aws_route53_record" "frontend" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = aws_lb.frontend.dns_name
    zone_id                = aws_lb.frontend.zone_id
    evaluate_target_health = true
  }
}

variable "domain_name" {
  default = "example.com"
}

output "frontend_record" {
  value = aws_route53_record.frontend.fqdn
}

output "backend_record" {
  value = aws_route53_record.backend.fqdn
}