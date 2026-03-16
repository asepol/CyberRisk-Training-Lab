#!/usr/bin/env bash
set -e

#############################################
# PRÉREQUIS
#############################################

if ! command -v curl >/dev/null 2>&1; then
    echo "[!] curl n'est pas installé. Installation..."
    apt update && apt install -y curl || yum install -y curl
fi

#############################################
# CONFIG GLOBALE
#############################################

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
STACK_DIR="$ROOT_DIR"
PROM_DIR="$STACK_DIR/prometheus"
GRAF_DIR="$STACK_DIR/grafana"
GRAF_PROV_DS="$GRAF_DIR/provisioning/datasources"
GRAF_PROV_DASH="$GRAF_DIR/provisioning/dashboards"
WIKI_CONTENT_DIR="$STACK_DIR/wiki-content"

COMPOSE_FILE="$ROOT_DIR/docker-lab/docker-compose.yml"

IP_VM=$(hostname -I | awk '{print $1}')
KIBANA_URL="http://$IP_VM:5601"

echo "==============================================="
echo " Configuration automatique de l'infrastructure"
echo " Racine projet : $ROOT_DIR"
echo " IP détectée   : $IP_VM"
echo "==============================================="

echo "[*] Création des dossiers..."
mkdir -p "$PROM_DIR" "$GRAF_PROV_DS" "$GRAF_PROV_DASH" "$WIKI_CONTENT_DIR"

#############################################
# 1. PROMETHEUS
#############################################
echo "[*] Configuration Prometheus..."

cat > "$PROM_DIR/prometheus.yml" << 'EOF'
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['prometheus:9090']
EOF

#############################################
# 2. GRAFANA
#############################################
echo "[*] Configuration Grafana..."

cat > "$GRAF_PROV_DS/prometheus.yml" << 'EOF'
apiVersion: 1

datasources:
  - name: Prometheus
    type: prometheus
    access: proxy
    url: http://prometheus:9090
    isDefault: true
EOF

cat > "$GRAF_PROV_DASH/prometheus-dashboard.json" << 'EOF'
{
  "id": null,
  "uid": "prom-basic",
  "title": "Prometheus - Vue de base",
  "timezone": "browser",
  "schemaVersion": 36,
  "version": 1,
  "panels": [
    {
      "type": "graph",
      "title": "Prometheus - Samples rate",
      "targets": [
        {
          "expr": "rate(prometheus_tsdb_head_samples_appended_total[5m])",
          "legendFormat": "samples/s",
          "refId": "A"
        }
      ],
      "gridPos": { "h": 8, "w": 24, "x": 0, "y": 0 }
    }
  ]
}
EOF

#############################################
# 3. WIKI.JS
#############################################
echo "[*] Préparation du contenu Wiki..."
mkdir -p "$WIKI_CONTENT_DIR"

#############################################
# 4. RESTART DES SERVICES
#############################################
echo "[*] Vérification du fichier docker-compose.yml..."

if [ ! -f "$COMPOSE_FILE" ]; then
    echo "[!] ERREUR : docker-compose.yml introuvable dans $COMPOSE_FILE"
    exit 1
fi

echo "[*] Redémarrage des services..."
docker compose -f "$COMPOSE_FILE" restart \
    prometheus grafana kibana wiki dvwa juice-shop mailhog nextcloud || true

#############################################
# 5. ATTENTE DE KIBANA
#############################################
echo "[*] Attente du démarrage de Kibana..."

until curl -s "$KIBANA_URL/api/status" | grep -q '"state":"green"'; do
    echo "  → Kibana pas encore prêt..."
    sleep 5
done

echo "  → Kibana est prêt !"

#############################################
# 6. CREATION DES INDEX PATTERNS
#############################################
echo "[*] Création des index patterns Kibana..."

curl -s -X POST "$KIBANA_URL/api/saved_objects/index-pattern" \
  -H "kbn-xsrf: true" \
  -H "Content-Type: application/json" \
  -d '{"attributes":{"title":"docker-*","timeFieldName":"@timestamp"}}' > /dev/null || true

curl -s -X POST "$KIBANA_URL/api/saved_objects/index-pattern" \
  -H "kbn-xsrf: true" \
  -H "Content-Type: application/json" \
  -d '{"attributes":{"title":"fluentbit-*","timeFieldName":"@timestamp"}}' > /dev/null || true

#############################################
# 7. INSTALLATION + CREATION COMPTE NEXTCLOUD
#############################################
echo "[*] Installation et configuration de Nextcloud..."

NEXTCLOUD_CONTAINER="nextcloud"
NC_USER="admin"
NC_PASS="Admin1234!"

# Vérification du conteneur
if ! docker ps --format '{{.Names}}' | grep -q "$NEXTCLOUD_CONTAINER"; then
    echo "[!] Impossible : conteneur Nextcloud introuvable."
else
    echo "  → Vérification si Nextcloud est déjà installé..."

    if docker exec -u www-data $NEXTCLOUD_CONTAINER php occ status 2>&1 | grep -q "installed: true"; then
        echo "  → Nextcloud est déjà installé."
    else
        echo "  → Installation automatique de Nextcloud (SQLite)..."

        docker exec -u www-data $NEXTCLOUD_CONTAINER php occ maintenance:install \
            --database=sqlite \
            --admin-user="$NC_USER" \
            --admin-pass="$NC_PASS"

        echo "  → Installation terminée."
        echo "     - Login admin : $NC_USER"
        echo "     - Mot de passe : $NC_PASS"
    fi

    echo "  → Vérification de l'utilisateur admin..."

    if docker exec -u www-data $NEXTCLOUD_CONTAINER php occ user:list | grep -q "$NC_USER"; then
        echo "  → L'utilisateur '$NC_USER' existe déjà."
    else
        echo "  → Création de l'utilisateur Nextcloud..."
        docker exec -u www-data -e OC_PASS="$NC_PASS" $NEXTCLOUD_CONTAINER \
            php occ user:add --password-from-env --display-name="Compte TP" "$NC_USER"

        echo "  → Utilisateur créé."
    fi
fi

#############################################
# 8. FIN
#############################################
echo
echo "==============================================="
echo " Infrastructure TP configurée"
echo "-----------------------------------------------"
echo "Prometheus : OK"
echo "Grafana    : OK"
echo "Kibana     : OK"
echo "Wiki       : OK"
echo "Nextcloud  : Installé + compte admin créé"
echo "==============================================="
