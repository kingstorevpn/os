#!/bin/bash

# =================================================================================
# FUNGSI EFEK LOADING BARU
# =================================================================================

# Fungsi loading untuk download dengan progress
function download_with_progress() {
    local url="$1"
    local filename="$2"
    local description="$3"
    
    echo -e "\033[0;36m╭─────────────────────────────────────────╮\033[0m"
    echo -e "\033[0;36m│ \033[1;37mMengunduh: $description\033[0;36m"
    echo -e "\033[0;36m╰─────────────────────────────────────────╯\033[0m"
    
    # Proses download sebenarnya dengan wget, output disembunyikan
    wget -q --show-progress --progress=bar:force:noscroll "$url" -O "$filename"
    chmod +x "$filename"
    echo -e "\033[1;32m✓ Unduhan Selesai!\033[0m\n"
}

# Fungsi loading untuk instalasi dengan animasi spinner
function install_with_animation() {
    local script_name="$1"
    local process_name="$2"
    
    echo -e "\033[0;35m╭─────────────────────────────────────────╮\033[0m"
    echo -e "\033[0;35m│ \033[1;37mMenginstal: $process_name\033[0;35m"
    echo -e "\033[0;35m╰─────────────────────────────────────────╯\033[0m"
    
    local spinner='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local i=0
    
    # Jalankan script di background
    ./"$script_name" >/dev/null 2>&1 &
    local pid=$!
    
    echo -ne "\033[0;33mMemproses: \033[1;37m"
    while kill -0 $pid 2>/dev/null; do
        printf "\b${spinner:$i:1}"
        i=$(( (i+1) % ${#spinner} ))
        sleep 0.1
    done
    
    echo -e "\b\033[1;32m✓ Instalasi Selesai!\033[0m"
    wait $pid
}

# =================================================================================
# SCRIPT UTAMA
# =================================================================================

function CEKIP () {
MYIP=$(curl -sS ipv4.icanhazip.com)
IPVPS=$(curl -sS https://raw.githubusercontent.com/gazzent/ip/main/ip | grep $MYIP | awk '{print $4}')
if [[ $MYIP == $IPVPS ]]; then
domain
Casper2
else
#  key2
  domain
  Casper2
fi
}
clear
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
BIBlue='\033[1;94m'       # Blue
BGCOLOR='\e[1;97;101m'    # WHITE RED
tyblue='\e[1;36m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
cd /root
if [ "${EUID}" -ne 0 ]; then
echo "You need to run this script as root"
exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
echo "OpenVZ is not supported"
exit 1
fi
localip=$(hostname -I | cut -d\  -f1)
hst=( `hostname` )
dart=$(cat /etc/hosts | grep -w `hostname` | awk '{print $2}')
if [[ "$hst" != "$dart" ]]; then
echo "$localip $(hostname)" >> /etc/hosts
fi
secs_to_human() {
echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds"
}
rm -rf /etc/rmbl
mkdir -p /etc/rmbl
mkdir -p /etc/rmbl/theme
mkdir -p /var/lib/ >/dev/null 2>&1
echo "IP=" >> /var/lib/ipvps.conf
clear
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ ${BGCOLOR}             MASUKKAN NAMA KAMU         ${NC}${BIBlue} │${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo " "
until [[ $name =~ ^[a-zA-Z0-9_.-]+$ ]]; do
read -rp "Masukan Nama Kamu Disini tanpa spasi : " -e name
done
rm -rf /etc/profil
echo "$name" > /etc/profil
echo ""
clear
author=$(cat /etc/profil)
echo ""
echo ""

function key2(){
clear
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ ${BGCOLOR} Please select a your Choice            ${BIBlue} │${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│  [ 1 ]  \033[1;37mTRIAL 1 HARI      ${NC}"
echo -e "${BIBlue}│  [ 2 ]  \033[1;37mMEMBER SUDAH BELI     ${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
until [[ $key =~ ^[12]+$ ]]; do 
read -p "   Please select numbers 1 atau 2 : " key
done
if [[ $key == "1" ]]; then
MYIP=$(curl -sS ipv4.icanhazip.com)
rm -rf /etc/github
mkdir /etc/github
curl -s https://pastebin.com/raw/t3aaqcej > /etc/github/api
curl -s https://pastebin.com/raw/cfivDKk2 > /etc/github/email
curl -s https://pastebin.com/raw/bSskAgjw > /etc/github/username
clear
APIGIT=$(cat /etc/github/api)
EMAILGIT=$(cat /etc/github/email)
USERGIT=$(cat /etc/github/username)
hhari=$(date -d "1 days" +"%Y-%m-%d")
mkdir /root/casper
cd /root/casper
wget https://raw.githubusercontent.com/gazzent/ip/main/ip >/dev/null 2>&1
echo "### $author $hhari $MYIP @trial" >> ipmini
sleep 1
rm -rf .git
git config --global user.email "${EMAILGIT}" >/dev/null 2>&1
git config --global user.name "${USERGIT}" >/dev/null 2>&1
git init >/dev/null 2>&1
git add ipmini 
git commit -m register >/dev/null 2>&1
git branch -M main >/dev/null 2>&1
git remote add origin https://github.com/${USERGIT}/permission >/dev/null 2>&1
git push -f https://${APIGIT}@github.com/${USERGIT}/permission >/dev/null 2>&1
sleep 1
rm -rf /root/rmbl
rm -rf /etc/github
clear
fi
if [[ $key == "2" ]]; then
clear
echo -e  "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e  "${BIBlue}│              MASUKKAN LICENSE KEY        │${NC}"
echo -e  "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo " "
read -rp "Masukan Key Kamu Disini (Ctrl + C Exit) : " -e kode

if [ -z $kode ]; then
echo -e "KODE SALAH SILAHKAN MASUKKAN ULANG KODENYA"
key2
fi
LIST=$(curl -sS https://raw.githubusercontent.com/RMBL-VPN/license/main/key | grep $kode | awk '{print $2}')
Key=$(curl -sS https://raw.githubusercontent.com/RMBL-VPN/license/main/key | grep $kode | awk '{print $3}')
KEY2=$(curl -sS https://raw.githubusercontent.com/RMBL-VPN/license/main/key | grep $kode | awk '{print $4}')
ADMIN=$(curl -sS https://raw.githubusercontent.com/RMBL-VPN/license/main/key | grep $kode | awk '{print $5}')
TOTALIP=$(curl -sS https://raw.githubusercontent.com/RMBL-VPN/license/main/key | grep $kode | awk '{print $6}')
cd
if [[ $kode == "RMBLVIP" ]]; then
MYIP=$(curl -sS ipv4.icanhazip.com)
rm -rf /etc/github
mkdir /etc/github
curl -s https://pastebin.com/raw/t3aaqcej > /etc/github/api
curl -s https://pastebin.com/raw/cfivDKk2 > /etc/github/email
curl -s https://pastebin.com/raw/bSskAgjw > /etc/github/username
clear
APIGIT=$(cat /etc/github/api)
EMAILGIT=$(cat /etc/github/email)
USERGIT=$(cat /etc/github/username)
hhari=$(date -d "30 days" +"%Y-%m-%d")
mkdir /root/rmbl
cd /root/rmbl
wget https://raw.githubusercontent.com/gazzent/ip/main/ip >/dev/null 2>&1

echo "### $author $hhari $MYIP @RMBL" >> ipmini

sleep 0.5
rm -rf .git
git config --global user.email "${EMAILGIT}" >/dev/null 2>&1
git config --global user.name "${USERGIT}" >/dev/null 2>&1
git init >/dev/null 2>&1
git add ipmini 
git commit -m register >/dev/null 2>&1
git branch -M main >/dev/null 2>&1
git remote add origin https://github.com/${USERGIT}/permission >/dev/null 2>&1
git push -f https://${APIGIT}@github.com/${USERGIT}/permission >/dev/null 2>&1
sleep 0.5
rm ipmini
elif [[ $kode == "RMBLVVIP" ]]; then
MYIP2=$(curl -sS ipv4.icanhazip.com)
author2=$(cat /etc/profil)
rm -rf /etc/github
mkdir /etc/github
curl -s https://pastebin.com/raw/t3aaqcej > /etc/github/api
curl -s https://pastebin.com/raw/cfivDKk2 > /etc/github/email
curl -s https://pastebin.com/raw/bSskAgjw > /etc/github/username
clear
APIGIT=$(cat /etc/github/api)
EMAILGIT=$(cat /etc/github/email)
USERGIT=$(cat /etc/github/username)
hhari2=$(date -d "999 days" +"%Y-%m-%d")
mkdir /root/rmbl
cd /root/rmbl
wget https://raw.githubusercontent.com/gazzent/ip/main/ip >/dev/null 2>&1

sed -i "/# VIP/a ### ${author2} ${hhari2} ${MYIP2} ON 999 VIP" /root/rmbl/ipmini

sleep 0.5
rm -rf .git
git config --global user.email "${EMAILGIT}" >/dev/null 2>&1
git config --global user.name "${USERGIT}" >/dev/null 2>&1
git init >/dev/null 2>&1
git add ipmini 
git commit -m register >/dev/null 2>&1
git branch -M main >/dev/null 2>&1
git remote add origin https://github.com/${USERGIT}/permission >/dev/null 2>&1
git push -f https://${APIGIT}@github.com/${USERGIT}/permission >/dev/null 2>&1
sleep 0.5
rm ipmini
elif [[ $kode == "SFADMIN" ]]; then
MYIP3=$(curl -sS ipv4.icanhazip.com)
author3=$(cat /etc/profil)
rm -rf /etc/github
mkdir /etc/github
curl -s https://pastebin.com/raw/t3aaqcej > /etc/github/api
curl -s https://pastebin.com/raw/cfivDKk2 > /etc/github/email
curl -s https://pastebin.com/raw/bSskAgjw > /etc/github/username
clear
APIGIT=$(cat /etc/github/api)
EMAILGIT=$(cat /etc/github/email)
USERGIT=$(cat /etc/github/username)
hhari3=$(date -d "999 days" +"%Y-%m-%d")
mkdir /root/rmbl
cd /root/rmbl
wget https://raw.githubusercontent.com/gazzent/ip/main/ip >/dev/null 2>&1

sed -i "/# RESELLER/a ### ${author3} ${hhari3} ${MYIP3} ON 999" /root/rmbl/ipmini

sleep 0.5
rm -rf .git
git config --global user.email "${EMAILGIT}" >/dev/null 2>&1
git config --global user.name "${USERGIT}" >/dev/null 2>&1
git init >/dev/null 2>&1
git add ipmini 
git commit -m register >/dev/null 2>&1
git branch -M main >/dev/null 2>&1
git remote add origin https://github.com/${USERGIT}/permission >/dev/null 2>&1
git push -f https://${APIGIT}@github.com/${USERGIT}/permission >/dev/null 2>&1
sleep 0.5
rm ipmini
elif [[ $kode == $Key ]]; then
MYIP=$(curl -sS ipv4.icanhazip.com)
rm -rf /etc/github
mkdir /etc/github
curl -s https://pastebin.com/raw/t3aaqcej > /etc/github/api
curl -s https://pastebin.com/raw/cfivDKk2 > /etc/github/email
curl -s https://pastebin.com/raw/bSskAgjw > /etc/github/username
clear
APIGIT=$(cat /etc/github/api)
EMAILGIT=$(cat /etc/github/email)
USERGIT=$(cat /etc/github/username)
hhari=$(date -d "$KEY2 days" +"%Y-%m-%d")
mkdir /root/rmbl
cd /root/rmbl
wget https://raw.githubusercontent.com/gazzent/ip/main/ip >/dev/null 2>&1
if [ "$ADMIN" = "ON" ]; then
sed -i "/# RESELLER/a ### ${author} ${hhari} ${MYIP} ${ADMIN} ${TOTALIP}" /root/rmbl/ipmini
else
echo "### $author $hhari $MYIP @$LIST" >> ipmini
fi

sleep 0.5
rm -rf .git
git config --global user.email "${EMAILGIT}" >/dev/null 2>&1
git config --global user.name "${USERGIT}" >/dev/null 2>&1
git init >/dev/null 2>&1
git add ipmini 
git commit -m register >/dev/null 2>&1
git branch -M main >/dev/null 2>&1
git remote add origin https://github.com/${USERGIT}/permission >/dev/null 2>&1
git push -f https://${APIGIT}@github.com/${USERGIT}/permission >/dev/null 2>&1
sleep 0.5
rm ipmini
wget https://raw.githubusercontent.com/RMBL-VPN/license/main/key >/dev/null 2>&1
if [ "$ADMIN" = "ON" ]; then
sed -i "/^### $LIST $Key $KEY2 $ADMIN $TOTALIP/d" /root/rmbl/key
else
sed -i "/^### $LIST $Key $KEY2/d" /root/rmbl/key
fi
sleep 0.5
rm -rf .git
git config --global user.email "${EMAILGIT}" >/dev/null 2>&1
git config --global user.name "${USERGIT}" >/dev/null 2>&1
git init >/dev/null 2>&1
git add key
git commit -m register >/dev/null 2>&1
git branch -M main >/dev/null 2>&1
git remote add origin https://github.com/${USERGIT}/license >/dev/null 2>&1
git push -f https://${APIGIT}@github.com/${USERGIT}/license >/dev/null 2>&1
rm -rf /root/rmbl
rm -rf /etc/github
clear
else
echo -e "KODE SALAH SILAHKAN MASUKKAN ULANG KODENYA"
sleep 1
key2
fi
fi
}
function domain(){
clear
cd
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ \033[1;37mPlease select a your Choice to Set Domain${BIBlue}│${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│  [ 1 ]  \033[1;37mDomain kamu sendiri       ${NC}"
echo -e "${BIBlue}│  [ 2 ]  \033[1;37mDomain yang punya script  ${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
until [[ $domain =~ ^[12]+$ ]]; do 
read -p "   Please select numbers 1 atau 2 : " domain
done
if [[ $domain == "1" ]]; then
clear
echo -e  "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e  "${BIBlue}│              \033[1;37mTERIMA KASIH                ${BIBlue}│${NC}"
echo -e  "${BIBlue}│         \033[1;37mSUDAH MENGGUNAKAN SCRIPT         ${BIBlue}│${NC}"
echo -e  "${BIBlue}│                \033[1;37Admin cloudvpn             ${BIBlue}│${NC}"
echo -e  "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo " "
until [[ $dnss =~ ^[a-zA-Z0-9_.-]+$ ]]; do 
read -rp "Masukan domain kamu Disini : " -e dnss
done
rm -rf /etc/xray
rm -rf /etc/v2ray
rm -rf /etc/nsdomain
rm -rf /etc/per
mkdir -p /etc/xray
mkdir -p /etc/v2ray
mkdir -p /etc/nsdomain
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/xray/slwdomain
touch /etc/v2ray/scdomain
echo "$dnss" > /root/domain
echo "$dnss" > /root/scdomain
echo "$dnss" > /etc/xray/scdomain
echo "$dnss" > /etc/v2ray/scdomain
echo "$dnss" > /etc/xray/domain
echo "$dnss" > /etc/v2ray/domain
echo "IP=$dnss" > /var/lib/ipvps.conf
echo ""
clear
fi
if [[ $domain == "2" ]]; then
clear
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ \033[1;37mPlease select a your Choice to Set Domain${BIBlue}│${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│  [ 1 ]  \033[1;37mDomain xxx.tepllovpn.eu.org          ${NC}"                                        
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
until [[ $domain2 =~ ^[1-5]+$ ]]; do 
read -p "   Please select numbers 1 sampai 1 : " domain2
done
fi
if [[ $domain2 == "1" ]]; then
clear
echo -e  "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e  "${BIBlue}│  \033[1;37mContoh subdomain xxx.tepllovpn.eu.org        ${BIBlue}│${NC}"
echo -e  "${BIBlue}│    \033[1;37mxxx jadi subdomain kamu               ${BIBlue}│${NC}"
echo -e  "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo " "
until [[ $dn1 =~ ^[a-zA-Z0-9_.-]+$ ]]; do
read -rp "Masukan subdomain kamu Disini tanpa spasi : " -e dn1
done
rm -rf /etc/xray
rm -rf /etc/v2ray
rm -rf /etc/nsdomain
rm -rf /etc/per
mkdir -p /etc/xray
mkdir -p /etc/v2ray
mkdir -p /etc/nsdomain
mkdir -p /etc/per
touch /etc/per/id
touch /etc/per/token
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/xray/slwdomain
touch /etc/v2ray/scdomain
echo "$dn1" > /root/subdomainx
cd
sleep 1
download_with_progress "https://raw.githubusercontent.com/gazzent/os/main/install/rmbl.sh" "rmbl.sh" "Domain Setup"
install_with_animation "rmbl.sh" "Domain Configuration"
clear
rm /root/subdomainx
fi
}
cat <<EOF>> /etc/rmbl/theme/green
BG : \E[40;1;42m
TEXT : \033[0;32m
EOF
cat <<EOF>> /etc/rmbl/theme/yellow
BG : \E[40;1;43m
TEXT : \033[0;33m
EOF
cat <<EOF>> /etc/rmbl/theme/red
BG : \E[40;1;41m
TEXT : \033[0;31m
EOF
cat <<EOF>> /etc/rmbl/theme/blue
BG : \E[40;1;44m
TEXT : \033[0;34m
EOF
cat <<EOF>> /etc/rmbl/theme/magenta
BG : \E[40;1;45m
TEXT : \033[0;35m
EOF
cat <<EOF>> /etc/rmbl/theme/cyan
BG : \E[40;1;46m
TEXT : \033[0;36m
EOF
cat <<EOF>> /etc/rmbl/theme/lightgray
BG : \E[40;1;47m
TEXT : \033[0;37m
EOF
cat <<EOF>> /etc/rmbl/theme/darkgray
BG : \E[40;1;100m
TEXT : \033[0;90m
EOF
cat <<EOF>> /etc/rmbl/theme/lightred
BG : \E[40;1;101m
TEXT : \033[0;91m
EOF
cat <<EOF>> /etc/rmbl/theme/lightgreen
BG : \E[40;1;102m
TEXT : \033[0;92m
EOF
cat <<EOF>> /etc/rmbl/theme/lightyellow
BG : \E[40;1;103m
TEXT : \033[0;93m
EOF
cat <<EOF>> /etc/rmbl/theme/lightblue
BG : \E[40;1;104m
TEXT : \033[0;94m
EOF
cat <<EOF>> /etc/rmbl/theme/lightmagenta
BG : \E[40;1;105m
TEXT : \033[0;95m
EOF
cat <<EOF>> /etc/rmbl/theme/lightcyan
BG : \E[40;1;106m
TEXT : \033[0;96m
EOF
cat <<EOF>> /etc/rmbl/theme/color.conf
lightcyan
EOF
function Casper2(){
cd
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1
clear
wget https://raw.githubusercontent.com/kingstorevpn/os/main/tools.sh &> /dev/null
chmod +x tools.sh 
bash tools.sh
clear
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
apt install git curl -y >/dev/null 2>&1
apt install python -y >/dev/null 2>&1
}
function Casper3(){
# Cek OS dan jalankan instalasi yang sesuai
if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
echo -e "${green}OS Terdeteksi: $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')${NC}"
setup_all
elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
echo -e "${green}OS Terdeteksi: $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')${NC}"
setup_all
else
echo -e " Your OS Is Not Supported ( ${YELLOW}$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')${FONT} )"
fi
}

function setup_all(){
clear
# 1. SSH & OpenVPN
download_with_progress "https://raw.githubusercontent.com/kingstorevpn/os/main/install/ssh-vpn.sh" "ssh-vpn.sh" "SSH & OpenVPN"
install_with_animation "ssh-vpn.sh" "SSH & OpenVPN Server"
sleep 1; clear

# 2. Xray
download_with_progress "https://raw.githubusercontent.com/kingstorevpn/os/main/install/ins-xray.sh" "ins-xray.sh" "Xray Core"
install_with_animation "ins-xray.sh" "Xray Services"
sleep 1; clear

# 3. Websocket SSH
download_with_progress "https://raw.githubusercontent.com/kingstorevpn/os/main/sshws/insshws.sh" "insshws.sh" "WebSocket SSH"
install_with_animation "insshws.sh" "WebSocket SSH Tunnel"
sleep 1; clear

# 4. Backup Menu
download_with_progress "https://raw.githubusercontent.com/kingstorevpn/os/main/install/set-br.sh" "set-br.sh" "Backup & Restore"
install_with_animation "set-br.sh" "Backup System"
sleep 1; clear

# 5. OHP
download_with_progress "https://raw.githubusercontent.com/kingstorevpn/os/main/sshws/ohp.sh" "ohp.sh" "OHP Tunnel"
install_with_animation "ohp.sh" "OHP Services"
sleep 1; clear

# 6. Extra Menu
download_with_progress "https://raw.githubusercontent.com/kingstorevpn/os/main/menu/update.sh" "update.sh" "Extra Menu"
install_with_animation "update.sh" "Extra Menu System"
sleep 1; clear

# 7. SlowDNS
download_with_progress "https://raw.githubusercontent.com/kingstorevpn/os/main/slowdns/installsl.sh" "installsl.sh" "SlowDNS Tunnel"
install_with_animation "installsl.sh" "SlowDNS Server"
sleep 1; clear

# 8. UDP Custom
download_with_progress "https://raw.githubusercontent.com/kingstorevpn/os/main/install/udp-custom.sh" "udp-custom.sh" "UDP Custom"
install_with_animation "udp-custom.sh" "UDP Custom Protocol"
sleep 1; clear

# 9. NoobzVPN
download_with_progress "https://raw.githubusercontent.com/gazzent/os/main/noobz/noobzvpns.zip" "noobzvpns.zip" "NoobzVPN Package"
echo -e "\033[0;35m╭─────────────────────────────────────────╮\033[0m"
echo -e "\033[0;35m│ \033[1;37mMenginstal: NoobzVPN Service\033[0;35m"
echo -e "\033[0;35m╰─────────────────────────────────────────╯\033[0m"
unzip -o noobzvpns.zip >/dev/null 2>&1
cd noobzvpns
bash install.sh > /dev/null 2>&1
cd ..
rm -rf noobzvpns noobzvpns.zip
systemctl restart noobzvpns
echo -e "\033[1;32m✓ Instalasi Selesai!\033[0m"
sleep 1; clear
}

function iinfo(){
domain=$(cat /etc/xray/domain)
TIMES="10"
CHATID="-1001839759989" 
KEY="7669028254:AAGiawvop_rQG3T-DTjxcqv8rP4TNcPAXac"
URL="https://api.telegram.org/bot$KEY/sendMessage"
ISP=$(cat /etc/xray/isp)
CITY=$(cat /etc/xray/city)
domain=$(cat /etc/xray/domain) 
TIME=$(date +'%Y-%m-%d %H:%M:%S')
RAMMS=$(free -m | awk 'NR==2 {print $2}')
MODEL2=$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')
MYIP=$(curl -sS ipv4.icanhazip.com)
IZIN=$(curl -sS https://raw.githubusercontent.com/gazzent/izin_new/main/ip | grep $MYIP | awk '{print $3}' )
d1=$(date -d "$IZIN" +%s)
d2=$(date -d "$today" +%s)
EXP=$(( (d1 - d2) / 86400 ))

TEXT="
<code>━━━━━━━━━━━━━━━━━━━━</code>
<code>⚠️ AUTOSCRIPT PREMIUM ⚠️</code>
<code>━━━━━━━━━━━━━━━━━━━━</code>
<code>NAME : </code><code>${author}</code>
<code>TIME : </code><code>${TIME} WIB</code>
<code>IP : </code><code>${MYIP}</code>
<code>ISP : </code><code>${ISP} $CITY</code>
<code>OS LINUX : </code><code>${MODEL2}</code>
<code>RAM : </code><code>${RAMMS} MB</code>
<code>━━━━━━━━━━━━━━━━━━━━</code>
<i> Notifikasi Installer Script...</i>
"'&reply_markup={"inline_keyboard":[[{"text":"ᴏʀᴅᴇʀ","url":"https://t.me/Candravpnz"},{"text":"GRUP","url":"https://t.me/CandravpnzStores"}]]}'
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
clear
}

CEKIP
Casper3
cat> /root/.profile << END
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
clear
welcome
END
chmod 644 /root/.profile
if [ -f "/root/log-install.txt" ]; then
rm /root/log-install.txt > /dev/null 2>&1
fi
if [ -f "/etc/afak.conf" ]; then
rm /etc/afak.conf > /dev/null 2>&1
fi
if [ ! -f "/etc/log-create-user.log" ]; then
echo "Log All Account " > /etc/log-create-user.log
fi
history -c
serverV=$( curl -sS https://raw.githubusercontent.com/kingstorevpn/os/main/versi  )
echo $serverV > /opt/.ver
aureb=$(cat /home/re_otm)
b=11
if [ $aureb -gt $b ]
then
gg="PM"
else
gg="AM"
fi
cd
curl -sS ifconfig.me > /etc/myipvps
curl -s ipinfo.io/city?token=751274028fe3c0 >> /etc/xray/city
curl -s ipinfo.io/org?token=751274028fe3c0  | cut -d " " -f 2-10 >> /etc/xray/isp
rm /root/setup.sh >/dev/null 2>&1
rm /root/installsl.sh >/dev/null 2>&1
rm /root/ssh-vpn.sh >/dev/null 2>&1
rm /root/ins-xray.sh >/dev/null 2>&1
rm /root/insshws.sh >/dev/null 2>&1
rm /root/set-br.sh >/dev/null 2>&1
rm /root/ohp.sh >/dev/null 2>&1
rm /root/update.sh >/dev/null 2>&1
rm /root/slowdns.sh >/dev/null 2>&1
rm -rf /etc/noobz
mkdir -p /etc/noobz
echo "" > /etc/xray/noob
secs_to_human "$(($(date +%s) - ${start}))" | tee -a log-install.txt
sleep 3
echo  ""
cd
iinfo
rm -rf *
echo -e "${BIBlue}╭════════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ ${BGCOLOR} INSTALL SCRIPT SELESAI..                 ${NC}${BIBlue} │${NC}"
echo -e "${BIBlue}╰════════════════════════════════════════════╯${NC}"
echo  ""
sleep 4
echo -e "[ ${yell}WARNING${NC} ] Do you want to reboot now ? (y/n)? "; read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi