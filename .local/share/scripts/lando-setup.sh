#!/usr/bin/env bash

sudo -v

LANDO_TLD=$(yq r ~/.lando/config.yml 'domain')

if [[ $OSTYPE =~ "darwin" ]]; then
  # Remove the CA if it already exists
  sudo security delete-certificate -c "Lando Local CA" &>/dev/null

  # Trust the new CA
  sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ~/.lando/certs/$LANDO_TLD.pem
fi

if [[ $(uname -r) =~ "MANJARO" ]]; then
  # Remove the CA if it already exists
  sudo trust anchor --remove "~/.lando/certs/$LANDO_TLD.pem" &>/dev/null
  sudo trust anchor --remove "~/.lando/certs/$LANDO_TLD.crt" &>/dev/null

  # Trust the new CA
  sudo trust anchor "~/.lando/certs/$LANDO_TLD.pem"
  sudo trust anchor "~/.lando/certs/$LANDO_TLD.crt"
fi
