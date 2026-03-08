#!/usr/bin/env bash
set -e

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
DASHBOARD_DIR="$ROOT_DIR/dashboard"
TP_DIR="$DASHBOARD_DIR/tp"

IP_VM=$(hostname -I | awk '{print $1}')

echo "==============================================="
echo " Configuration du Dashboard CyberRisk-Training-Lab"
echo " IP détectée : $IP_VM"
echo "==============================================="

if [ ! -d "$TP_DIR" ]; then
  echo "Erreur : dossier TP introuvable : $TP_DIR"
  exit 1
fi

echo "[*] Remplacement de IP_VM dans les TP HTML..."

find "$TP_DIR" -type f -name "tp*.html" -print0 | while IFS= read -r -d '' file; do
  sed -i "s|IP_VM|$IP_VM|g" "$file"
  echo "  - $file mis à jour"
done

echo
echo "[*] Vérification..."
grep -R "IP_VM" -n "$TP_DIR" || echo "Aucune occurrence restante."

echo
echo "==============================================="
echo " Dashboard configuré"
echo " Accès : http://$IP_VM:8080"
echo "==============================================="
