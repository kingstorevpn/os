#!/bin/bash
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
NC="\e[0m"
RED="\033[0;31m"
WH='\033[1;37m'
ipsaya=$(curl -sS ipv4.icanhazip.com)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://raw.githubusercontent.com/kingstorevpn/ip/main/ip"
checking_sc() {
    useexp=$(curl -sS "$data_ip" | grep "$ipsaya" | awk '{print $3}')
    date_list=$(date +%Y-%m-%d)

    if [[ $(date -d "$date_list" +%s) -lt $(date -d "$useexp" +%s) ]]; then
        echo -e " [INFO] Fetching server version..."
        REPO="https://raw.githubusercontent.com/kingstorevpn/os/main/" # Ganti dengan URL repository Anda
        serverV=$(curl -sS ${REPO}versi)

        if [[ -f /opt/.ver ]]; then
            localV=$(cat /opt/.ver)
        else
            localV="0"
        fi

        if [[ $serverV == $localV ]]; then
            echo -e " [INFO] Script sudah versi terbaru ($serverV). Tidak ada update yang diperlukan."
            return
        else
            echo -e " [INFO] Versi script berbeda. Memulai proses update script..."
            wget -q https://raw.githubusercontent.com/kingstorevpn/os/main/menu/update.sh -O update.sh
            chmod +x update.sh
            ./update.sh
            echo $serverV > /opt/.ver.local
            return
        fi
    else
        echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
        echo -e "\033[42m          404 NOT FOUND AUTOSCRIPT          \033[0m"
        echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
        echo -e ""
        echo -e "            \033[91;1mPERMISSION DENIED !\033[0m"
        echo -e "   \033[0;33mYour VPS\033[0m $ipsaya \033[0;33mHas been Banned\033[0m"
        echo -e "     \033[0;33mBuy access permissions for scripts\033[0m"
        echo -e "             \033[0;33mContact Admin :\033[0m"
        echo -e "      \033[2;32mWhatsApp\033[0m wa.me/6281573872702"
        echo -e "      \033[2;32mTelegram\033[0m t.me/candravpnz"
        echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
cd
#        {
#> /etc/cron.d/cpu_otm

#cat> /etc/cron.d/cpu_otm << END
#SHELL=/bin/sh
#PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
#*/5 * * * * root /usr/bin/detek
#END

#wget myrid.my.id/os/install/detek
#mv detek /usr/bin/detek
#chmod +x /usr/bin/detek
#detek
#   } &> /dev/null &
echo "Loading Extract and Setup detek" | lolcat
    fi
}

checking_sc
cd
today=$(date -d "0 days" +"%Y-%m-%d")
Exp2=$(curl -sS https://raw.githubusercontent.com/kingstorevpn/ip/main/ip | grep $ipsaya | awk '{print $3}')
d1=$(date -d "$Exp2" +%s)
d2=$(date -d "$today" +%s)
certificate=$(( (d1 - d2) / 86400 ))
echo "$certificate Hari" > /etc/masaaktif
xray2=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $xray2 == "running" ]]; then
echo -ne
else
systemctl stop xray
systemctl start xray
fi
haproxy2=$(systemctl status haproxy | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $haproxy2 == "running" ]]; then
echo -ne
else
systemctl stop haproxy
systemctl start haproxy
fi
nginx2=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx2 == "running" ]]; then
echo -ne
else
systemctl stop nginx
systemctl start nginx
fi
cd
if [[ -e /usr/bin/kyt ]]; then
nginx=$( systemctl status kyt | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
echo -ne
else
systemctl restart kyt
systemctl start kyt
fi
fi
ws=$(systemctl status ws | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $ws == "running" ]]; then
echo -ne
else
systemctl restart ws
systemctl start ws
fi