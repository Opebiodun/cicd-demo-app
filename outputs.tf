# Infrastructure Outputs
output "ec2_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.web_server.public_ip
}

output "ec2_instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.web_server.id
}

output "website_url" {
  description = "URL to access the website"
  value       = "http://${aws_instance.web_server.public_ip}"
}

# S3 Outputs
output "assets_bucket_name" {
  description = "Name of S3 bucket for assets"
  value       = aws_s3_bucket.assets.id
}

output "assets_bucket_url" {
  description = "URL of S3 assets bucket"
  value       = "https://${aws_s3_bucket.assets.bucket}.s3.amazonaws.com"
}

output "pipeline_artifacts_bucket" {
  description = "S3 bucket for pipeline artifacts"
  value       = aws_s3_bucket.codepipeline_artifacts.id
}

# CI/CD Outputs
output "codepipeline_name" {
  description = "Name of CodePipeline"
  value       = aws_codepipeline.pipeline.name
}

output "codepipeline_url" {
  description = "URL to CodePipeline console"
  value       = "https://console.aws.amazon.com/codesuite/codepipeline/pipelines/${aws_codepipeline.pipeline.name}/view"
}

output "codedeploy_application" {
  description = "CodeDeploy application name"
  value       = aws_codedeploy_app.app.name
}

output "github_connection_arn" {
  description = "GitHub connection ARN (needs manual activation)"
  value       = aws_codestarconnections_connection.github.arn
}

output "github_connection_status" {
  description = "GitHub connection status"
  value       = aws_codestarconnections_connection.github.connection_status
}

# SSH Command
output "ssh_command" {
  description = "SSH command to connect to EC2"
  value       = "ssh -i ~/.ssh/${var.key_name}.pem ec2-user@${aws_instance.web_server.public_ip}"
}

# Deployment Summary
output "deployment_summary" {
  description = "Summary of deployment"
  value = <<-EOT
  
  ============================================
  🎉 CI/CD Infrastructure Deployed!
  ============================================
  
  📍 EC2 Web Server:
    Public IP: ${aws_instance.web_server.public_ip}
    URL: http://${aws_instance.web_server.public_ip}
    SSH: ssh -i ~/.ssh/${var.key_name}.pem ec2-user@${aws_instance.web_server.public_ip}
  
  📦 S3 Buckets:
    Assets: ${aws_s3_bucket.assets.id}
    Pipeline: ${aws_s3_bucket.codepipeline_artifacts.id}
  
  🚀 CI/CD Pipeline:
    Pipeline: ${aws_codepipeline.pipeline.name}
    Console: https://console.aws.amazon.com/codesuite/codepipeline/pipelines/${aws_codepipeline.pipeline.name}/view
  
  ⚠️  NEXT STEPS:
  1. Activate GitHub connection in AWS Console
  2. Push code to GitHub repository
  3. Watch automatic deployment!
  
  ============================================
  EOT
}