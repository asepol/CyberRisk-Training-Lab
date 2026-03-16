#!/usr/bin/env bash
set -e

echo "==============================================="
echo " Envoi automatique des emails du TP (via swaks)"
echo "==============================================="

#############################################
# 0. Détection automatique de l'IP Mailhog
#############################################

MAILHOG_HOST="$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mailhog 2>/dev/null || true)"

if [ -z "$MAILHOG_HOST" ]; then
    echo "[!] ERREUR : Impossible de détecter l'IP du conteneur Mailhog."
    echo "    Vérifie que le conteneur est lancé :"
    echo "    docker ps | grep mailhog"
    exit 1
fi

MAILHOG_PORT="1025"

echo "[*] Mailhog détecté : $MAILHOG_HOST:$MAILHOG_PORT"
echo

#############################################
# Fonction d'envoi d'email
#############################################
send_mail() {
    local TO="$1"
    local FROM="$2"
    local SUBJECT="$3"
    local BODY="$4"

    swaks --to "$TO" \
          --from "$FROM" \
          --server "$MAILHOG_HOST:$MAILHOG_PORT" \
          --header "Subject: $SUBJECT" \
          --body "$BODY" >/dev/null 2>&1

    echo "  → Email envoyé : $SUBJECT"
}

#############################################
# 1. DVWA – Alerte sécurité
#############################################
echo "[*] Envoi : DVWA Security Alert"
send_mail "student@lab.local" "dvwa@lab.local" \
          "DVWA Security Alert" \
          "Une activité suspecte a été détectée sur votre compte DVWA."

#############################################
# 2. Nextcloud – Reset password
#############################################
echo "[*] Envoi : Nextcloud Password Reset"
send_mail "student@lab.local" "nextcloud@lab.local" \
          "Nextcloud Password Reset" \
          "Cliquez ici pour réinitialiser votre mot de passe."

#############################################
# 3. Wiki.js – Invitation
#############################################
echo "[*] Envoi : Wiki.js Invitation"
send_mail "student@lab.local" "wiki@lab.local" \
          "Invitation Wiki.js" \
          "Vous avez été invité à rejoindre le Wiki interne."

#############################################
# 4. Juice Shop – Contact support
#############################################
echo "[*] Envoi : Juice Shop Contact"
send_mail "support@lab.local" "client@lab.local" \
          "Juice Shop – Contact" \
          "Bonjour, j’ai un problème avec ma commande."

#############################################
# 5. Email de phishing interne
#############################################
echo "[*] Envoi : Email de phishing interne"
send_mail "employee@lab.local" "it-support@lab.local" \
          "URGENT – Mise à jour de sécurité" \
          "Votre mot de passe expire aujourd’hui. Connectez-vous ici : http://fake-login.lab.local"

#############################################
# FIN
#############################################
echo
echo "==============================================="
echo " Tous les emails du TP ont été envoyés."
echo " Ouvre Mailhog : http://<IP_VM>:8025"
echo "==============================================="
