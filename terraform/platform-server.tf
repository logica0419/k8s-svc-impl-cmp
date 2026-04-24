resource "sakuracloud_server" "platform" {
  count      = 1
  name       = "platform"
  core       = 24
  memory     = 192
  commitment = "dedicatedcpu"
  disks      = [sakuracloud_disk.platform[count.index].id]

  network_interface {
    upstream = "shared"
  }
  disk_edit_parameter {
    hostname        = "platform"
    password        = random_password.cluster_pass.result
    disable_pw_auth = "true"
    ssh_keys        = split("\n", trimspace(data.http.key.response_body))
  }
  timeouts {
    create = "1h"
    delete = "1h"
  }
}
