output "cluster_pass" {
  value     = random_password.cluster_pass.result
  sensitive = true
}

output "platform_ip_address" {
  value = sakuracloud_server.platform[*].ip_address
}
