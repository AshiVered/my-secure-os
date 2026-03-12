#!/usr/bin/env bash
set -euo pipefail

REPO="kdroidFilter/Zayit"
API_URL="https://api.github.com/repos/${REPO}/releases/latest"

# זיהוי ארכיטקטורה
arch="$(uname -m)"
rpm_arch="x86_64"
if [[ "$arch" == "aarch64" || "$arch" == "arm64" ]]; then
    rpm_arch="aarch64"
fi

echo "Querying latest Zayit RPM for ${rpm_arch}..."
release_json="$(curl -fsSL "${API_URL}")"
asset_url="$(printf '%s\n' "${release_json}" | grep -Eo "https://github.com/${REPO}/releases/download/[^\" ]*zayit-[0-9.]+-1\\.${rpm_arch}\\.rpm" | head -n 1)"

if [ -z "${asset_url}" ]; then
    echo "Could not find Zayit RPM."
    exit 1
fi

tmpfile="/tmp/zayit.rpm"
echo "Downloading: ${asset_url}"
curl -fL -o "${tmpfile}" "${asset_url}"

echo "Installing Zayit via rpm-ostree..."
# בבניית Image משתמשים בפקודה הזו כדי "להלחים" את החבילה למערכת
rpm-ostree install "${tmpfile}"

echo "Zayit installation complete."
