#!/bin/bash
# ============================
#  UPDATE SCRIPT – TEST VERSION (SAFE)
#  Tidak hapus user
#  Tidak ubah SSH/PAM
#  Tidak restart service
#  Hanya update menu
# ============================

clear
echo "======================================"
echo "       UPDATE TEST MODE (SAFE)        "
echo "======================================"
sleep 1

# Repo dan lokasi file menu.zip yang benar
REPO_ZIP="https://raw.githubusercontent.com/kingstorevpn/os/main/menu/menu.zip"

# Lokasi file menu di server
MENU_DIR="/usr/local/sbin"

# Download menu.zip terbaru
echo "[INFO] Mengunduh file menu terbaru..."
wget -q -O /root/menu.zip "$REPO_ZIP"

if [ ! -f /root/menu.zip ]; then
    echo "[ERROR] Gagal mendownload menu.zip dari repo."
    echo "URL: $REPO_ZIP"
    exit 1
fi

echo "[OK] menu.zip berhasil diunduh."

# Ekstrak ke folder temporary
rm -rf /root/menu-new
mkdir -p /root/menu-new
unzip -oq /root/menu.zip -d /root/menu-new

if [ ! -d /root/menu-new ]; then
    echo "[ERROR] Gagal extract menu.zip."
    exit 1
fi

echo "[OK] menu.zip berhasil diextract."

# Backup menu lama
mkdir -p /root/menu-backup
cp -r $MENU_DIR/* /root/menu-backup/ 2>/dev/null

echo "[OK] Menu lama dibackup ke /root/menu-backup"

# Kopi menu baru ke /usr/local/sbin
echo "[INFO] Mengupdate file menu..."
for file in /root/menu-new/*; do
    if [ -f "$file" ]; then
        cp "$file" "$MENU_DIR/"
        chmod +x "$MENU_DIR/$(basename "$file")"
    fi
done

echo "[OK] Semua file menu berhasil diupdate."
echo

echo "======================================"
echo "        UPDATE TEST COMPLETE          "
echo "======================================"
echo
echo "[INFO] Tidak ada user dihapus."
echo "[INFO] Tidak ada konfigurasi SSH diubah."
echo "[INFO] Tidak ada service inti direstart."
echo "[INFO] Tidak ada password/shell yang diganggu."
echo
echo "Silakan test menu seperti biasa."
echo "Jika aman, saya lanjutkan versi FINAL."
