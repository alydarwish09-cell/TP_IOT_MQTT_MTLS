#!/bin/bash

# Script de génération de certificats mTLS pour MQTT
# Date: 28 Mars 2026

echo "--- Préparation de l'environnement ---"
mkdir -p certs csr keys
chmod 700 keys

echo "--- 1. Création de l'Autorité de Certification (CA) Root ---"
openssl genrsa -out keys/ca.key 2048
openssl req -new -x509 -key keys/ca.key -out certs/ca.crt -days 3650 \
-subj "/C=fr/ST=ile-de-france/L=paris/O=IB/OU=IB-Data/CN=MQTT-CA"

echo "--- 2. Génération des clés et CSR (Broker & Client) ---"
openssl genrsa -out keys/broker.key 2048
openssl genrsa -out keys/client.key 2048

openssl req -new -key keys/broker.key -out csr/broker.csr \
-subj "/C=FR/ST=Ile-de-France/L=Paris/O=IB/OU=IB-Data/CN=MQTT-test"

openssl req -new -key keys/client.key -out csr/client.csr \
-subj "/C=FR/ST=Ile-de-France/L=Paris/O=IB/OU=IB-Data/CN=iot-client-iba"

echo "--- 3. Signature des certificats par la CA ---"
openssl x509 -req -in csr/broker.csr -CA certs/ca.crt -CAkey keys/ca.key \
-CAcreateserial -out certs/broker.crt -days 365

openssl x509 -req -in csr/client.csr -CA certs/ca.crt -CAkey keys/ca.key \
-CAcreateserial -out certs/client.crt -days 365

echo "--- 4. Sécurisation des fichiers ---"
chmod 600 keys/*.key
chmod 644 certs/*.crt csr/*.csr

echo " Génération terminée. Les certificats sont dans /certs et les clés dans /keys."
