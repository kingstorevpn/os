#!/bin/bash
name="XIAO WAN"

cd /etc/systemd/system/
rm -rf kyt.service
cd
grenbo="\e[92;1m"
NC='\e[0m'

cd /usr/bin
rm -rf regip
rm -rf regip.zip
sudo apt update
sudo apt install pip
apt install unzip
apt install neofetch -y
cd /usr/bin
wget https://raw.githubusercontent.com/kingstorevpn/os/main/bregis/regip.zip
unzip regip.zip
chmod +x /usr/bin/regip/*
rm -rf regip.zip
clear
pip install requests python-telegram-bot==13.7
clear
cd

echo ""
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[1;97;101m          ADD BOT PANEL          \e[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -e -p "Masukkan ID Telegram :" admin
echo -e ''$admin'' >> /usr/bin/regip/xwan.txt
clear

cat > /etc/systemd/system/regip.service << END
[Unit]
Description=Simple kyt - @kyt
After=network.target

[Service]
WorkingDirectory=/usr/bin/regip
ExecStart=/usr/bin/python3  regis.py
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl start regip 
systemctl enable regip
systemctl restart regip
cd /root
rm -rf kyt.sh
rm -rf kyt.sh.1
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "🍀VPS SUCCESSFULLY INSTALL BOT🍀"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "🌹NAME AUTHOR : $name"
echo -e "🌺ADMIN BOT   : $admin"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
clear

echo " Installations selesai, kode /start untuk menjalankan bot"
