TP : Sécurisation IoT - mTLS MQTT avec OpenSSL

Ce dépôt contient les ressources et scripts nécessaires pour mettre en place une authentification mutuelle TLS (mTLS) sur un broker MQTT (Mosquitto).

Objectifs :

- Générer une autorité de certification (CA) racine.

- Créer et signer des certificats pour le broker et le client.

- Configurer Mosquitto pour exiger l'authentification par certificat.

- Tester la sécurité de la connexion avec les outils client.

Structure du projet :

- scripts/ : Scripts d'automatisation pour la génération des clés.

- config/ : Exemple de configuration pour Mosquitto.

- certs/ : (Dossier local) Stockage des certificats (.crt).

- keys/ : (Dossier local) Stockage des clés privées (.key) - Ignoré par Git.

Utilisation rapide :

1. Génération des certificats

Exécutez le script d'automatisation :
chmod +x setup_certs.sh
./setup_certs.sh

2. Configuration Mosquitto :
Copiez les fichiers générés dans /etc/mosquitto/certs/ et utilisez le fichier mosquitto.conf fourni dans le dossier config/.

3. Tests de connexion :

Test avec succès (Certificats fournis)
mosquitto_pub -h localhost -p 8883 \
  --cafile ca.crt --cert client.crt --key client.key \
  -t "test/secured" -m "mTLS OK"
