#!/bin/sh

sudo apt-get install samba
sudo systemctl enable smbd
sudo systemctl start smbd

