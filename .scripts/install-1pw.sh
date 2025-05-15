#!/usr/bin/env bash

if command -v "op" &> /dev/null; then
    op whoami
    if [ $? -ne 0 ]; then
        echo "Need to Auth to OP"
        eval $(op signin)
    fi
else
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
        sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg && \
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | \
        sudo tee /etc/apt/sources.list.d/1password.list && \
        sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/ && \
        curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | \
        sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol && \
        sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22 && \
        curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
        sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg && \
        sudo apt update && sudo apt install 1password-cli
    eval $(op signin) || exit 1
fi
echo "OP Installed and Authenticated"
op document get --vault linux-kernel "gpg.key" -o gpg.key
op document get --vault linux-kernel "gpg.pub" -o gpg.pub

# Import GPG Key to keyring
op run --env-file='.env' -- gpg --batch --passphrase GPGPASS --import gpg.key
