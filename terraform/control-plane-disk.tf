resource "sakuracloud_disk" "k8s_control_plane_disk" {
  count             = 1
  name              = "control-plane"
  source_archive_id = data.sakuracloud_archive.ubuntu_archive.id
  size              = 20
  timeouts {
    create = "1h"
    delete = "1h"
  }
}
