output "ec2_ip" {
  value = aws_instance.wordpress_app.public_ip
}