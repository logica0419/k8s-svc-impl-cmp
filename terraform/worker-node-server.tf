resource "sakuracloud_server" "k8s_worker_node" {
  count  = 1
  name   = "${var.prefix}-worker-node-${count.index + 1}"
  core   = 2
  memory = 4
  disks  = [sakuracloud_disk.k8s_worker_node_disk[count.index].id]

  network_interface {
    upstream = "shared"
  }
  disk_edit_parameter {
    hostname        = "${var.prefix}-worker-node-${count.index + 1}"
    password        = random_password.cluster_pass.result
    disable_pw_auth = "true"
    ssh_keys        = split("\n", trimspace(data.http.key.response_body))
  }
  timeouts {
    create = "1h"
    delete = "1h"
  }
}
