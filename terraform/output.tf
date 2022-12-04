output "ec2-ip" {
  value = try(aws_instance.app-server1.public_ip)
}