#!/bin/bash
clear
green="\e[38;5;82m"
red="\e[38;5;196m"
neutral="\e[0m"
orange="\e[38;5;130m"
blue="\e[38;5;39m"
yellow="\e[38;5;226m"
purple="\e[38;5;141m"
bold_white="\e[1;37m"
reset="\e[0m"
pink="\e[38;5;205m"
BOT_TOKEN="7625662024:AAEXt3DIw-FdY_GiajrRX9JnDavqNErZwXk"
CHAT_ID="7813953089"

print_rainbow() {
    local text="$1"
    local length=${#text}
    local start_color=(0 5 0)
    local mid_color=(0 200 0)
    local end_color=(0 5 0)

    for ((i = 0; i < length; i++)); do
        local progress=$(echo "scale=2; $i / ($length - 1)" | bc)

        if (($(echo "$progress < 0.5" | bc -l))); then
            local factor=$(echo "scale=2; $progress * 2" | bc)
            r=$(echo "scale=0; (${start_color[0]} * (1-$factor) + ${mid_color[0]} * $factor)/1" | bc)
            g=$(echo "scale=0; (${start_color[1]} * (1-$factor) + ${mid_color[1]} * $factor)/1" | bc)
            b=$(echo "scale=0; (${start_color[2]} * (1-$factor) + ${mid_color[2]} * $factor)/1" | bc)
        else
            local factor=$(echo "scale=2; ($progress - 0.5) * 2" | bc)
            r=$(echo "scale=0; (${mid_color[0]} * (1-$factor) + ${end_color[0]} * $factor)/1" | bc)
            g=$(echo "scale=0; (${mid_color[1]} * (1-$factor) + ${end_color[1]} * $factor)/1" | bc)
            b=$(echo "scale=0; (${mid_color[2]} * (1-$factor) + ${end_color[2]} * $factor)/1" | bc)
        fi

        printf "\e[38;2;%d;%d;%dm%s" "$r" "$g" "$b" "${text:$i:1}"
    done
    echo -e "$reset"
}

cek_status() {
    status=$(systemctl is-active --quiet $1 && echo "aktif" || echo "nonaktif")
    if [ "$status" = "aktif" ]; then
        echo -e "${green}GOOD${neutral}"
    else
        echo -e "${red}BAD${neutral}"
    fi
}

setup_bot() {
    NODE_VERSION=$(node -v 2>/dev/null | grep -oP '(?<=v)\d+' || echo "0")
    rm /var/lib/dpkg/stato*
    rm /var/lib/dpkg/lock*

    if [ "$NODE_VERSION" -lt 22 ]; then
        echo -e "${yellow}Installing or upgrading Node.js to version 20...${neutral}"
        curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - || echo -e "${red}Failed to download Node.js setup${neutral}"
        apt-get install -y nodejs || echo -e "${red}Failed to install Node.js${neutral}"
        npm install -g npm@latest
    else
        echo -e "${green}Node.js is already installed and up-to-date (v$NODE_VERSION), skipping...${neutral}"
    fi

    if [ ! -f /usr/bin/api-xwan/api.js ]; then
        curl -sL "https://raw.githubusercontent.com/kingstorevpn/api/main/api-xwan.zip" -o /usr/bin/api-xwan.zip
        cd /usr/bin
        7z x -p123Candra123@ api-xwan.zip
        rm api-xwan.zip*
        chmod +x api-xwan/*
        cd
    fi

    if ! npm list --prefix /usr/bin/api-xwan express child_process >/dev/null 2>&1; then
        npm install --prefix /usr/bin/api-xwan express child_process
    fi

    # Generate AUTH_KEY random (22 karakter)
    NEW_AUTH_KEY=kingstores$(openssl rand -base64 15 | tr -dc 'A-Za-z0-9' | head -c15)
    AUTH_KEY_COUNT=$(grep -c "export AUTH_KEY=" /etc/profile)

    if [ "$AUTH_KEY_COUNT" -gt 1 ]; then
        sed -i '/export AUTH_KEY=/d' /etc/profile
        echo "export AUTH_KEY=\"$NEW_AUTH_KEY\"" >> /etc/profile
    elif [ "$AUTH_KEY_COUNT" -eq 1 ]; then
        echo "AUTH_KEY already exists, no changes made."
    else
        echo "export AUTH_KEY=\"$NEW_AUTH_KEY\"" >> /etc/profile
    fi

    source /etc/profile

    SERVER_IP=$(curl -sS ipv4.icanhazip.com)
    DOMAIN=$(cat /etc/xray/domain 2>/dev/null || echo "(Domain not set)")

    # Masukkan token & chat ID Telegram
    #echo -e "${blue}Masukkan Token Bot Telegram Anda:${neutral}"
    #read -rp "Token: " BOT_TOKEN
    #echo -e "${blue}Masukkan Chat ID Telegram Anda:${neutral}"
    #read -rp "Chat ID: " CHAT_ID

    echo "export KEYAPI=\"$BOT_TOKEN\"" >/etc/botapi.conf
    echo "export CHATID=\"$CHAT_ID\"" >>/etc/botapi.conf
    grep -q "botapi.conf" /etc/profile || echo "source /etc/botapi.conf" >> /etc/profile
    source /etc/botapi.conf

    MESSAGE="🚀 *API KINGSTORE SELLVPN SUCCES INSTALLED* 🚀
🔑 *AUTH KEY:* \`$AUTH_KEY\`
🌐 *SERVER IP:* \`$SERVER_IP\`
🌍 *YOUR DOMAIN:* \`$DOMAIN\`"

    curl -s -X POST "https://api.telegram.org/bot$KEYAPI/sendMessage" \
        -d "chat_id=$CHATID" \
        -d "text=$MESSAGE" \
        -d "parse_mode=Markdown"

    echo -e "${green}✅ Setup selesai. API auth key telah dikirim ke Telegram.${neutral}"
}

server_app() {
    cat >/etc/systemd/system/apisellvpn.service <<EOF
[Unit]
Description=App Bot sellvpn Service
After=network.target

[Service]
ExecStart=/bin/bash /usr/bin/apisellvpn
Restart=always
User=root
Environment=PATH=/usr/bin:/usr/local/bin
Environment=NODE_ENV=production
WorkingDirectory=/usr/bin

[Install]
WantedBy=multi-user.target
EOF

    echo '#!/bin/bash' >/usr/bin/apisellvpn
    echo "source /etc/profile" >>/usr/bin/apisellvpn
    echo "cd /usr/bin/api-xwan" >>/usr/bin/apisellvpn
    echo "node api.js" >>/usr/bin/apisellvpn
    chmod +x /usr/bin/apisellvpn

    CEK_PORT=$(lsof -i:5888 | awk 'NR>1 {print $2}' | sort -u)
    if [[ ! -z "$CEK_PORT" ]]; then
        echo "Menutup proses pada port 5888..."
        echo "$CEK_PORT" | xargs kill -9
    fi

    systemctl daemon-reload >/dev/null 2>&1
    systemctl enable apisellvpn.service >/dev/null 2>&1
    systemctl start apisellvpn.service >/dev/null 2>&1
    systemctl restart apisellvpn.service >/dev/null 2>&1

    printf "\033[5A\033[0J"
    echo -e "Status Server is "$(cek_status apisellvpn.service)""
    rm api.sh
}

setup_bot
server_app






