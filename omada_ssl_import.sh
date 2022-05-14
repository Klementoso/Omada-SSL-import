#!/bin/bash

# Omada-SSL-import.sh
# SSL Certifcate Import Script for Omada Controller on Linux
# Tested on Ubuntu 20.04
# This script is a modified version of the script made by user Ermax on TP-Link forums
# See https://community.tp-link.com/en/business/forum/topic/96192?page=2 for the original post and script
# Version 1.0
# Last Updated Mar 17 2022

OMADA_HOSTNAME=mycontrollerurl.domain
OMADA_SERVICE=omada

service "${OMADA_SERVICE}" stop
rm /opt/tplink/EAPController/keystore/eap.cer
rm /opt/tplink/EAPController/keystore/eap.keystore
cp /root/.acme.sh/"${OMADA_HOSTNAME}"/"${OMADA_HOSTNAME}".cer /opt/tplink/EAPController/keystore/eap.cer
openssl pkcs12 -export -in /root/.acme.sh/"${OMADA_HOSTNAME}"/"${OMADA_HOSTNAME}".cer -inkey /root/.acme.sh/"${OMADA_HOSTNAME}"/"${OMADA_HOSTNAME}".key -name eap -out /root/.acme.sh/"${OMADA_HOSTNAME}"/"${OMADA_HOSTNAME}".p12 -password pass:tplink
keytool -importkeystore -deststorepass tplink -destkeystore /opt/tplink/EAPController/keystore/eap.keystore -srckeystore /root/.acme.sh/"${OMADA_HOSTNAME}"/"${OMADA_HOSTNAME}".p12 -srcstoretype PKCS12 -srcstorepass tplink
service "${OMADA_SERVICE}" start
