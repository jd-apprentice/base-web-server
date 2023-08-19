output "instance_public_ip" {
  value = aws_instance.example_webserver.public_ip
}
