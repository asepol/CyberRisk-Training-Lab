#!/bin/bash

DB_CONTAINER="wiki-db"
DB_USER="wikijs"
DB_NAME="wiki"
BACKUP_FILE="wiki_backup.sql"

echo "=== Vérification du fichier de backup ==="
if [ ! -f "$BACKUP_FILE" ]; then
    echo "ERREUR : Le fichier $BACKUP_FILE est introuvable."
    exit 1
fi

echo "=== Vérification du conteneur PostgreSQL ==="
if ! docker ps --format '{{.Names}}' | grep -q "^${DB_CONTAINER}$"; then
    echo "ERREUR : Le conteneur ${DB_CONTAINER} n'est pas démarré."
    exit 1
fi

echo "=== Déconnexion des utilisateurs ==="
docker exec -i $DB_CONTAINER psql -U $DB_USER -d postgres -c "
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = '${DB_NAME}';
"

echo "=== Suppression complète de la base ==="
docker exec -i $DB_CONTAINER psql -U $DB_USER -d postgres -c "DROP DATABASE IF EXISTS ${DB_NAME};"

echo "=== Recréation d'une base propre ==="
docker exec -i $DB_CONTAINER psql -U $DB_USER -d postgres -c "CREATE DATABASE ${DB_NAME};"

echo "=== Import du backup ==="
cat "$BACKUP_FILE" | docker exec -i $DB_CONTAINER psql -U $DB_USER -d $DB_NAME

echo "=== Restauration terminée ==="
echo "Redémarre Wiki.js : docker compose restart wiki"
