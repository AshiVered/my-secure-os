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
# ==========================================
# ביטול יכולות Sudo למשתמשים
# ==========================================

# 1. יצירת חוק שדורס את כל ההרשאות ומונע מכל משתמש להריץ כל פקודה כ-Sudo
echo "ALL ALL=(ALL) !ALL" > /etc/sudoers.d/99-block-sudo
chmod 0440 /etc/sudoers.d/99-block-sudo

# 2. הסרת הרשאת ה-SUID מהקובץ הבינארי של Sudo (מונע מהתוכנה את היכולת הטכנית לשנות הרשאות)
chmod a-s /usr/bin/sudo
chmod a-s /usr/bin/su

# 1. Restrict permission management to ROOT ONLY (prevents users from making files executable)
# chmod 700 /usr/bin/chmod
# chmod 700 /usr/bin/setfacl

# 2. Restrict Flatpak management tools to ROOT ONLY (keeps the engine running for the OS)
chmod 700 /usr/bin/flatpak

# 3. Restrict critical system manipulation tools to ROOT ONLY
chmod 700 /usr/bin/rpm-ostree
chmod 700 /usr/bin/su

