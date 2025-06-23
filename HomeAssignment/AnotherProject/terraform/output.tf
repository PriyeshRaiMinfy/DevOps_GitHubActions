output "public_ip" {
    description = "EC2 instance public IP"
    value       = aws_instance.web.public_ip
}
