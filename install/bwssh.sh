#!/bin/bash

# File log SSH
LOG_FILE="/tmp/login.db"

# Mengambil IP dan pengguna dari log
declare -A user_ips

while IFS= read -r line; do
    # Contoh baris: 2347373 - 'Taryadi' - 127.0.0.1:34834
    user=$(echo "$line" | awk -F"'" '{print $2}')
    ip=$(echo "$line" | awk -F" - " '{print $3}' | cut -d':' -f1)
    port=$(echo "$line" | awk -F":" '{print $NF}')
    
    user_ips["$user"]="$ip:$port"
done < "$LOG_FILE"

# Monitor penggunaan bandwidth
while true; do
    for user in "${!user_ips[@]}"; do
        ip_port="${user_ips[$user]}"
        ip=$(echo "$ip_port" | cut -d':' -f1)
        port=$(echo "$ip_port" | cut -d':' -f2)

        # Menggunakan 'ss' untuk mendapatkan statistik koneksi
        traffic_info=$(ss -i state established "( dport = :$port ) or ( sport = :$port )")
        
        # Ambil data bytes_sent dan bytes_received dari output
        bytes_sent=$(echo "$traffic_info" | grep -oP 'bytes_sent:\K\d+')
        bytes_received=$(echo "$traffic_info" | grep -oP 'bytes_received:\K\d+')

        # Tampilkan hasil
        if [[ -n "$bytes_sent" ]] || [[ -n "$bytes_received" ]]; then
            echo "User: $user, IP: $ip_port, Bytes Sent: ${bytes_sent:-0}, Bytes Received: ${bytes_received:-0}"
        else
            echo "User: $user, IP: $ip_port, No Data Transferred"
        fi
    done
    sleep 10  # Tunggu 10 detik sebelum memeriksa lagi
done

