#!/usr/bin/env bash
# installer_simple_sbin.sh — Versi sederhana untuk penggunaan pribadi
# Install langsung ke /usr/local/sbin tanpa checksum, tanpa password zip.

set -Eeuo pipefail
IFS=$'\n\t'

# ====== VARIABEL ======
REPO_BASE="https://raw.githubusercontent.com/kingstorevpn/os/main/menu/"   # <- ganti sesuai kebutuhan
ARTIFACT="menu.zip"                         # <- nama file zip
INSTALL_DIR="/usr/local/sbin"               # <- folder instalasi
NEED_7ZIP=true                               # true kalau pakai 7z

# ====== OPSI ======
LOG_FILE="/var/log/myapp-install.log"
CURL_OPTS=(--fail --location --show-error --connect-timeout 10 --retry 3 --retry-delay 2)
TMP_DIR="$(mktemp -d /tmp/myapp.XXXXXX)"
trap 'rc=$?; rm -rf "$TMP_DIR"; exit $rc' EXIT

log() { echo "[INFO] $*" | tee -a "$LOG_FILE"; }
die() { echo "[ERROR] $*" | tee -a "$LOG_FILE" >&2; exit 1; }

require_root() {
  if [[ "${EUID}" -ne 0 ]]; then
    die "Jalankan sebagai root atau gunakan sudo."
  fi
}

check_prereqs() {
  command -v curl >/dev/null 2>&1 || die "curl tidak ditemukan."
  if [[ "$NEED_7ZIP" == "true" ]]; then
    if ! command -v 7z >/dev/null 2>&1; then
      log "Menginstal p7zip-full..."
      apt-get update -y >>"$LOG_FILE" 2>&1 || die "apt-get update gagal"
      DEBIAN_FRONTEND=noninteractive apt-get install -y p7zip-full >>"$LOG_FILE" 2>&1 || die "Instal p7zip-full gagal"
    fi
  fi
}

fetch_artifact() {
  local url="${REPO_BASE%/}/$ARTIFACT"
  local out="$TMP_DIR/$ARTIFACT"
  log "Mengunduh artefak: $url"
  curl "${CURL_OPTS[@]}" -o "$out" "$url" || die "Unduhan gagal: $url"
}

extract_artifact() {
  mkdir -p "$INSTALL_DIR"
  local zip="$TMP_DIR/$ARTIFACT"
  log "Ekstraksi ke $INSTALL_DIR"
  if [[ "$NEED_7ZIP" == "true" ]]; then
    7z x -o"$TMP_DIR/extract" "$zip" >>"$LOG_FILE" 2>&1 || die "Ekstraksi gagal"
  else
    unzip -q "$zip" -d "$TMP_DIR/extract" >>"$LOG_FILE" 2>&1 || die "Ekstraksi gagal"
  fi

  cp -av "$TMP_DIR/extract/"* "$INSTALL_DIR/" >>"$LOG_FILE" 2>&1
  chmod +x "$INSTALL_DIR"/*
}

post_install_notes() {
  log "Instalasi selesai. File ada di: $INSTALL_DIR"
  log "Log installer: $LOG_FILE"
}

main() {
  require_root
  check_prereqs
  fetch_artifact
  extract_artifact
  post_install_notes
}

main "$@"
