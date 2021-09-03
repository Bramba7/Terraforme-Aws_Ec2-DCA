
output "key_name" {
  value = aws_key_pair.key_pair.key_name
}
output "Terminal" {
  value = "sudo ssh -i ${aws_key_pair.key_pair.key_name}.pem ubuntu@"
}
output "public_connection_string" {

  value = aws_instance.ec2[*].public_ip
}