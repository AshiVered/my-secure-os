#!/usr/bin/env bash
set -euo pipefail

echo "Configuring default keyboard layouts (English and Hebrew)..."
mkdir -p /etc/skel/.config

cat <<EOF > /etc/skel/.config/kxkbrc
[Layout]
DisplayNames=,
LayoutList=us,il
LayoutLoopCount=-1
Model=pc104
ResetOldOptions=true
SwitchMode=Global
Use=true
Options=grp:alt_shift_toggle
EOF

chmod 0644 /etc/skel/.config/kxkbrc
