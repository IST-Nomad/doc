#!/bin/bash
./opt/google/chrome/chrome --start-fullscreen
#sudo nano /etc/systemd/system/start_google.service
#sudo systemctl enable start_google.service
ini
[Unit]
Description=Запуск Chrome
[Service]
ExecStart=/home/tv/script/google_start.sh
Type=simple
Restart=on-failure
[Install]
WantedBy=multi-user.target


#@reboot /home/tv/script/google_start.sh



@reboot sleep 10 && /home/tv/script/google_start.sh >/dev/null 2>&1