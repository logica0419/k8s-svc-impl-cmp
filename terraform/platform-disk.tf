resource "sakuracloud_disk" "platform" {
  count             = 1
  name              = "platform"
  source_archive_id = data.sakuracloud_archive.ubuntu_archive.id
  size              = 1 * 1024
  timeouts {
    create = "1h"
    delete = "1h"
  }
}
