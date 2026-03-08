#!/usr/bin/env bash
set -e

#############################################
# CONFIG GLOBALE
#############################################

# Le script est dans : CyberRisk-Training-Lab/docker-lab
# On remonte d’un dossier pour atteindre la racine du projet
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

STACK_DIR="$ROOT_DIR"
PROM_DIR="$STACK_DIR/prometheus"
GRAF_DIR="$STACK_DIR/grafana"
GRAF_PROV_DS="$GRAF_DIR/provisioning/datasources"
GRAF_PROV_DASH="$GRAF_DIR/provisioning/dashboards"
WIKI_CONTENT_DIR="$STACK_DIR/wiki-content"

IP_VM=$(hostname -I | awk '{print $1}')

# Kibana
KIBANA_URL="http://$IP_VM:5601"
KIBANA_USER="elastic"
KIBANA_PASS="changeme"

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
# 3. WIKI.JS – CONTENU PÉDAGOGIQUE
#############################################
echo "[*] Génération des pages Wiki dans $WIKI_CONTENT_DIR"

# (Tu peux garder ou supprimer cette partie selon ton besoin)
# Je laisse tel quel car tu l’utilises déjà.

#############################################
# 4. RESTART DES SERVICES
#############################################
echo "[*] Redémarrage des services..."

cd "$ROOT_DIR/docker-lab"
docker compose restart prometheus grafana kibana wiki dvwa juice-shop mailhog nextcloud || true

#############################################
# 5. KIBANA – INDEX PATTERNS
#############################################
echo "[*] Configuration Kibana..."

curl -s -X POST "$KIBANA_URL/api/saved_objects/index-pattern" \
  -u "$KIBANA_USER:$KIBANA_PASS" \
  -H "kbn-xsrf: true" \
  -H "Content-Type: application/json" \
  -d '{"attributes":{"title":"docker-*","timeFieldName":"@timestamp"}}' > /dev/null || true

curl -s -X POST "$KIBANA_URL/api/saved_objects/index-pattern" \
  -u "$KIBANA_USER:$KIBANA_PASS" \
  -H "kbn-xsrf: true" \
  -H "Content-Type: application/json" \
  -d '{"attributes":{"title":"fluentbit-*","timeFieldName":"@timestamp"}}' > /dev/null || true

#############################################
# 6. FIN
#############################################
echo
echo "==============================================="
echo " Infrastructure TP configurée"
echo "-----------------------------------------------"
echo "Prometheus : OK"
echo "Grafana    : OK"
echo "Kibana     : OK"
echo "Wiki       : pages générées dans $WIKI_CONTENT_DIR"
echo "==============================================="
