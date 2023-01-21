//
// Module: vpc
//
output "id" {
  description = "returns a string"
  value       = aws_route53_zone.public.id
}

output "name_servers" {
  description = "returns a list of string"
  value       = aws_route53_zone.public.name_servers
}

output "zone_id" {
  description = "returns a string"
  value       = aws_route53_zone.public.zone_id
}

output "public" {
  value = aws_route53_zone.public
}
