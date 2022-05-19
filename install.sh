#!/bin/sh

cat > /usr/local/bin/auto-reboot1.sh <<- "EOF"
#!/bin/bash
sleep 180
while :
do
SERVER=noip.com
ping -c1 ${SERVER} > /dev/null
if [ $? != 0 ]
then
#
sudo reboot
fi
  sleep 60
done
EOF
#
cat > /lib/systemd/system/auto-reboot1.service  <<- "EOF"
[Unit]
Description=Auto-Reboot1

[Service]
User=root
ExecStart=/usr/local/bin/auto-reboot1.sh

[Install]
WantedBy=default.target

EOF
####
chmod +x /usr/local/bin/auto-reboot1.sh
chmod 755 /lib/systemd/system/auto-reboot1.service
systemctl daemon-reload
systemctl enable auto-reboot1.service
systemctl start auto-reboot1.service
