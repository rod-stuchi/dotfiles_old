#! /bin/sh

sync-h() {
  cp -avR --parents .local/share/zathura                       /disks/1TB/backup-histories
  cp -avR --parents .local/share/konsole                       /disks/1TB/backup-histories
  cp -avR --parents .config/ranger/{history,bookmarks,tagged}  /disks/1TB/backup-histories
  cp -avR --parents .config/sinew.in                           /disks/1TB/backup-histories
}
