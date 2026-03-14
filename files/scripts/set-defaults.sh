#!/usr/bin/env bash
set -euo pipefail

mkdir -p /etc/skel/.config


# הגדרת מקלדת
cat <<EOF > /etc/skel/.config/kxkbrc
[Layout]
LayoutList=us,il
Options=grp:alt_shift_toggle
Use=true
EOF

# הגדרת שורת המשימות עם זית, אובסידיאן ו-OnlyOffice
cat <<EOF > /etc/skel/.config/plasma-org.kde.plasma.desktop-appletsrc
[SerializationSettings]
FreeCanary=true

[Applets][1][Configuration][General]
launchers=applications:zayit-Zayit.desktop,applications:onlyoffice-desktopeditors.desktop
EOF
