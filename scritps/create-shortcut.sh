#!/bin/bash
set -euo pipefail

mkdir -p /etc/skel/Desktop

cat <<EOF > /etc/skel/Desktop/zayit.desktop
[Desktop Entry]
Name=Zayit
Exec=zayit
Icon=zayit
Type=Application
Categories=Education;
EOF

chmod +x /etc/skel/Desktop/zayit.desktop
