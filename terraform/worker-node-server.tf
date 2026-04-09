resource "sakuracloud_server" "k8s_worker_node" {
  count  = 1
  name   = "worker-node-${count.index + 1}"
  core   = 20
  memory = 48
  disks  = [sakuracloud_disk.k8s_worker_node_disk[count.index].id]

  network_interface {
    upstream = "shared"
  }
  disk_edit_parameter {
    hostname        = "worker-node-${count.index + 1}"
    password        = random_password.cluster_pass.result
    disable_pw_auth = "true"
    ssh_keys        = split("\n", trimspace(data.http.key.response_body))
  }
  timeouts {
    create = "1h"
    delete = "1h"
  }
}
