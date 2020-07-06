output "Admin_UI" {
  value = "https://${opentelekomcloud_networking_floatingip_v2.floatip_1.address}:7012"
}

output "SSH_Access" {
  value = "ssh -p 7014 linux@${opentelekomcloud_networking_floatingip_v2.floatip_1.address}"
}

output "Web_UI" {
  value = "https://${opentelekomcloud_networking_floatingip_v2.floatip_1.address}:7017"
}
