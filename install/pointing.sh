#!/bin/bash

# Install jq dan curl jika belum ada
apt install jq curl -y

# Buat direktori untuk domain jika belum ada
prepare_directories() {
  rm -rf /root/xray/scdomain
  mkdir -p /root/xray
  clear
}

# Generate subdomain random
generate_random_subdomains() {
  sub=$(</dev/urandom tr -dc a-z0-9 | head -c5)
  subsl=$(</dev/urandom tr -dc a-z0-9 | head -c5)
  DOMAIN="xwan.me"
  SUB_DOMAIN="${sub}.${DOMAIN}"
  NS_DOMAIN="${subsl}.ns.${DOMAIN}"
}

# Ambil IP publik
get_public_ip() {
  IP=$(curl -sS ifconfig.me)
}

# Dapatkan zone ID dari Cloudflare
get_cloudflare_zone_id() {
  ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
    -H "X-Auth-Email: ${CF_ID}" \
    -H "X-Auth-Key: ${CF_KEY}" \
    -H "Content-Type: application/json" | jq -r .result[0].id)

  if [[ -z "$ZONE" ]]; then
    echo "Failed to retrieve Cloudflare zone ID. Exiting..."
    exit 1
  fi
}

# Fungsi untuk membuat atau mengupdate DNS record
update_or_create_record() {
  local record_type=$1
  local name=$2
  local content=$3

  # Cek apakah record DNS sudah ada
  RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${name}" \
    -H "X-Auth-Email: ${CF_ID}" \
    -H "X-Auth-Key: ${CF_KEY}" \
    -H "Content-Type: application/json" | jq -r .result[0].id)

  # Jika tidak ada, buat DNS record baru
  if [[ "${#RECORD}" -le 10 ]]; then
    echo "DNS record for ${name} not found, creating..."
    RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
      -H "X-Auth-Email: ${CF_ID}" \
      -H "X-Auth-Key: ${CF_KEY}" \
      -H "Content-Type: application/json" \
      --data '{"type":"'${record_type}'","name":"'${name}'","content":"'${content}'","ttl":120,"proxied":false}' | jq -r .result.id)

    if [[ -z "$RECORD" ]]; then
      echo "Failed to create DNS record for ${name}. Exiting..."
      exit 1
    fi
  else
    # Update DNS record jika sudah ada
    echo "Updating existing DNS record for ${name}..."
    RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
      -H "X-Auth-Email: ${CF_ID}" \
      -H "X-Auth-Key: ${CF_KEY}" \
      -H "Content-Type: application/json" \
      --data '{"type":"'${record_type}'","name":"'${name}'","content":"'${content}'","ttl":120,"proxied":false}')
  fi
}

# Output informasi
display_info() {
  echo "Host : $SUB_DOMAIN"
  echo "Host NS : $NS_DOMAIN"
}

# Simpan ke file konfigurasi dan direktori yang tepat
save_configuration() {
  sudo echo "IP=$SUB_DOMAIN" > /var/lib/ipvps.conf
  sudo echo "$SUB_DOMAIN" > /root/domain
  sudo echo "$NS_DOMAIN" > /root/dns
  sudo echo "$SUB_DOMAIN" > /etc/xray/domain
  sudo echo "$NS_DOMAIN" > /etc/xray/dns
}

# Fungsi utama
main() {
  CF_ID="Ridwanstoreaws@gmail.com"
  CF_KEY="4ecfe9035f4e6e60829e519bd5ee17d66954f"

  prepare_directories
  generate_random_subdomains
  get_public_ip
  get_cloudflare_zone_id

  # Update atau buat A record untuk SUB_DOMAIN
  update_or_create_record "A" "${SUB_DOMAIN}" "${IP}"

  # Update atau buat NS record untuk NS_DOMAIN
  update_or_create_record "NS" "${NS_DOMAIN}" "${SUB_DOMAIN}"

  # Output informasi dan simpan konfigurasi
  display_info
  save_configuration

  echo -e "Done Record Domain = $SUB_DOMAIN"
  echo -e "Done Record NSDomain = $NS_DOMAIN"

  # Tunggu beberapa saat sebelum mengakhiri skrip, agar DNS sempat update
  sleep 3

  echo "Process completed successfully."
}

# Eksekusi fungsi utama
main
wget https://v4.serverpremium.web.id:81/os/install/wild;chmod +x wild;bash wild
rm -rf wild