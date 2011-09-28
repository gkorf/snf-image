#! /bin/bash

### BEGIN TASK INFO
# Provides:		ResizeMounted
# RunBefore:            UmountImage
# RunAfter:		MountImage
# Short-Description:	Resize filesystem to use all the available space
### END TAST INFO

set -e
. /usr/share/snf-image/common.sh

if [ ! -d "$SNF_IMAGE_TARGET" ]; then
    log_error "Target directory \`$SNF_IMAGE_TARGET\' is missing"
fi

# Write a diskpart script to %SystemDrive%\Windows\SnfScripts. Sysprep will
# try to execute this script during the specialize pass.
mkdir -p "$SNF_IMAGE_TARGET/Windows/SnfScripts"
cat > "$SNF_IMAGE_TARGET/Windows/SnfScripts/ExtendFilesystem" <<EOF
select disk 0
select volume 1
extend filesystem
exit
EOF

cleanup
trap - EXIT

exit 0

# vim: set sta sts=4 shiftwidth=4 sw=4 et ai :

