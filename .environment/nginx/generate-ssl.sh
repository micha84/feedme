#!/bin/bash

SSL_DIR="/etc/ssl/exconcept"
SSL_NAME="exconcept"

#Change to your company details
commonname=*.local
country=DE
state=BW
locality=Stuttgart
organization=ExconceptGmbh
organizationalunit=IT
email=administrator@exconcept.com

password=exConcept1234

KEY_FILE=$SSL_DIR/$SSL_NAME.key
CRT_FILE=$SSL_DIR/$SSL_NAME.crt

#Create directory
mkdir -p "$SSL_DIR"

#Generate a key

openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout $KEY_FILE -out $CRT_FILE -subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
