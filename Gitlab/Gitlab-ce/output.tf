output "gitlab_url" {
  value = "http://${aws_instance.gitlab_instance.public_ip}"
}
