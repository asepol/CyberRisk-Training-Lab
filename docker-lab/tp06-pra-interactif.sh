#!/usr/bin/env bash

# ============================================================
# TP6 – PRA/PCA INTERACTIF (Nextcloud + MinIO)
# ============================================================

NEXTCLOUD_CONTAINER="nextcloud"
BACKUP_FILE="nextcloud-data.tar.gz"
BUCKET_NAME="nextcloud-backup"

pause() {
    echo
    read -p "Appuyez sur Entrée pour continuer..."
    echo
}

clear
echo "=============================================================="
echo "      TP6 – PRA/PCA INTERACTIF (Nextcloud + MinIO)"
echo "=============================================================="
echo

# Vérification du conteneur Nextcloud
if ! docker ps --format '{{.Names}}' | grep -q "$NEXTCLOUD_CONTAINER"; then
    echo "[ERREUR] Le conteneur Nextcloud n'est pas lancé."
    exit 1
fi

# Menu principal
while true; do
    echo "---------------- MENU TP6 ----------------"
    echo "1) Étape 1 – Vérifier Nextcloud et uploader un fichier"
    echo "2) Étape 2 – Créer une sauvegarde du dossier data"
    echo "3) Étape 3 – Envoyer la sauvegarde dans MinIO"
    echo "4) Étape 4 – Simuler une panne (suppression des données)"
    echo "5) Étape 5 – Restaurer depuis MinIO"
    echo "6) Étape 6 – Vérifier la restauration"
    echo "7) Quitter"
    echo "------------------------------------------"
    read -p "Choisissez une option : " choix
    echo

    case $choix in

        1)
            echo "=== Étape 1 – Vérification Nextcloud ==="
            echo "Ouvrez Nextcloud : http://IP_VM:8082"
            echo "Connectez-vous et uploadez un fichier (ex: test.txt)."
            pause
        ;;

        2)
            echo "=== Étape 2 – Création de la sauvegarde ==="
            echo "[*] Compression du dossier /var/www/html/data..."
            docker exec $NEXTCLOUD_CONTAINER tar -czf /tmp/$BACKUP_FILE /var/www/html/data
            docker cp $NEXTCLOUD_CONTAINER:/tmp/$BACKUP_FILE .
            echo "→ Sauvegarde créée : $BACKUP_FILE"
            pause
        ;;

        3)
            echo "=== Étape 3 – Upload dans MinIO ==="
            echo "[*] Configuration du client MinIO..."
            mc alias set minio http://localhost:9000 minioadmin minioadmin >/dev/null 2>&1 || true

            echo "[*] Création du bucket (si absent)..."
            mc mb -p minio/$BUCKET_NAME >/dev/null 2>&1 || true

            echo "[*] Upload de la sauvegarde..."
            mc cp $BACKUP_FILE minio/$BUCKET_NAME/
            echo "→ Sauvegarde envoyée dans MinIO."
            pause
        ;;

        4)
            echo "=== Étape 4 – Simulation de panne ==="
            read -p "CONFIRMATION : Voulez-vous vraiment supprimer les données Nextcloud ? (o/n) : " confirm
            if [[ "$confirm" == "o" ]]; then
                docker exec $NEXTCLOUD_CONTAINER rm -rf /var/www/html/data/*
                echo "→ Panne simulée : données supprimées."
            else
                echo "→ Annulé."
            fi
            pause
        ;;

        5)
            echo "=== Étape 5 – Restauration depuis MinIO ==="
            echo "[*] Téléchargement de la sauvegarde..."
            mc cp minio/$BUCKET_NAME/$BACKUP_FILE ./restore.tar.gz

            echo "[*] Copie dans le conteneur..."
            docker cp restore.tar.gz $NEXTCLOUD_CONTAINER:/tmp/

            echo "[*] Extraction..."
            docker exec $NEXTCLOUD_CONTAINER tar -xzf /tmp/restore.tar.gz -C /

            echo "[*] Redémarrage de Nextcloud..."
            docker compose restart nextcloud

            echo "→ Restauration terminée."
            pause
        ;;

        6)
            echo "=== Étape 6 – Vérification ==="
            echo "[*] Contenu du dossier restauré :"
            docker exec $NEXTCLOUD_CONTAINER ls /var/www/html/data
            echo
            echo "Ouvrez Nextcloud et vérifiez que votre fichier est revenu."
            pause
        ;;

        7)
            echo "Fermeture du TP6 interactif."
            exit 0
        ;;

        *)
            echo "Option invalide."
        ;;
    esac
done

