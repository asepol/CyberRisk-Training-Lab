#!/usr/bin/env bash
set -e

echo "==============================================="
echo " CyberRisk-Training-Lab – Installation complète"
echo "==============================================="

cd docker-lab

echo "[1/3] Lancement de la stack Docker..."
docker compose up -d

echo "[2/3] Configuration de l'infrastructure..."
chmod +x config-infra.sh
./config-infra.sh

echo "[3/3] Configuration du dashboard..."
cd ..
chmod +x configure-dashboard.sh
./configure-dashboard.sh

echo
echo "==============================================="
echo " Installation terminée !"
echo "-----------------------------------------------"
echo " Dashboard : http://$(hostname -I | awk '{print $1}'):8080"
echo " Wiki.js   : http://$(hostname -I | awk '{print $1}'):8083"
echo " Grafana   : http://$(hostname -I | awk '{print $1}'):3001"
echo " Kibana    : http://$(hostname -I | awk '{print $1}'):5601"
echo "==============================================="
