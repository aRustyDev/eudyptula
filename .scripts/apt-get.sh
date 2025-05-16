#!/usr/bin/env bash

echo ":: apt-add-repository"
sudo add-apt-repository ppa:longsleep/golang-backports

echo ":: apt-get update"
sudo apt-get update

echo ":: apt-get upgrade"
sudo apt-get upgrade -y

echo ":: apt-get install"
sudo apt install -y golang-go python3-pip make kmod dwarves gcc linux-headers-$(KERNEL_VERSION) libappindicator1 gnupg2

echo ":: install witness"
bash <(curl -s https://raw.githubusercontent.com/in-toto/witness/main/install-witness.sh)
