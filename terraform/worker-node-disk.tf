resource "sakuracloud_disk" "k8s_worker_node_disk" {
  count             = 1
  name              = "worker-node-${count.index + 1}"
  source_archive_id = data.sakuracloud_archive.ubuntu_archive.id
  size              = 20
  timeouts {
    create = "1h"
    delete = "1h"
  }
}
