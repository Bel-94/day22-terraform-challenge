output "alb_dns_name" {
  description = "Public DNS of the Application Load Balancer"
  value       = aws_lb.web.dns_name
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "artifact_bucket" {
  description = "S3 bucket used to store immutable plan artifacts"
  value       = aws_s3_bucket.artifacts.bucket
}
