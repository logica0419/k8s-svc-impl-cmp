resource "sakuracloud_server" "k8s_control_plane" {
  count  = 1
  name   = "${var.prefix}-control-plane"
  core   = 10
  memory = 16
  disks  = [sakuracloud_disk.k8s_control_plane_disk[count.index].id]

  network_interface {
    upstream = "shared"
  }
  disk_edit_parameter {
    hostname        = "control-plane"
    password        = random_password.cluster_pass.result
    disable_pw_auth = "true"
    ssh_keys        = split("\n", trimspace(data.http.key.response_body))
  }
  timeouts {
    create = "1h"
    delete = "1h"
  }
}
