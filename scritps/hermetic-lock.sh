#!/bin/bash
set -euo pipefail

echo "Executing Hermetic Lockdown..."

# 1. חסימת שירותים (Masking)
systemctl mask NetworkManager
systemctl mask wpa_supplicant
systemctl mask bluetooth

# 2. הסרת מודולי קרנל של רשת (כדי שלא יהיו דרייברים)
# אנחנו יוצרים קובץ Blacklist שמונע טעינת דרייברים של Wi-Fi ו-Ethernet
cat <<EOF > /etc/modprobe.d/no-net.conf
blacklist iwlwifi
blacklist rtw88_8822ce
blacklist ath10k_pci
blacklist e1000e
blacklist r8169
EOF

# 3. מחיקת בינאריים רגישים (ליתר ביטחון)
rm -f /usr/bin/nmcli # כלי השליטה ברשת
rm -f /usr/bin/nmtui

# 4. נעילת Root מוחלטת
passwd -l root

