# 📘 CyberRisk Training Lab – Plateforme pédagogique de cybersécurité

Bienvenue dans **CyberRisk-Training-Lab**, une plateforme complète permettant d’enseigner et de pratiquer :

- la gestion des risques  
- la conformité (ISO 27001, ISO 27002, ISO 27005, RGPD, NIS2…)  
- la cybersécurité offensive et défensive  
- la supervision (SIEM, logs, dashboards)  
- l’analyse d’incidents  
- la gestion documentaire (Wiki.js)  

Ce laboratoire est conçu pour être **simple à déployer**, **portable**, et **100% automatisé** grâce à Docker et aux scripts fournis.

---

## 🏗️ 1. Architecture générale

La plateforme repose sur une stack Docker complète :

| Composant      | Rôle |
|----------------|------|
| **Nginx Dashboard** | Interface principale pour accéder aux TP |
| **DVWA** | Application vulnérable pour tests d’attaque |
| **Juice Shop** | Application vulnérable OWASP |
| **Nextcloud** | Stockage collaboratif |
| **MinIO** | Stockage objet S3 |
| **Mailhog** | Serveur SMTP de test |
| **Prometheus** | Monitoring |
| **Grafana** | Dashboards de supervision |
| **Elasticsearch** | Stockage des logs |
| **Kibana** | Visualisation des logs |
| **Fluent Bit** | Collecte des logs |
| **Wiki.js** | Documentation pédagogique |
| **PostgreSQL** | Base de données Wiki.js |

Les réseaux Docker sont segmentés :

- `frontend`
- `backend`
- `dmz`

---

## 🌐 2. URLs des services

Après installation, les services sont accessibles via l’IP de la VM :

| Service | URL |
|--------|-----|
| **Dashboard TP** | http://IP_VM:8080 |
| **DVWA** | http://IP_VM:8081 |
| **Nextcloud** | http://IP_VM:8082 |
| **Wiki.js** | http://IP_VM:8083 |
| **Juice Shop** | http://IP_VM:3005 |
| **Grafana** | http://IP_VM:3001 |
| **Kibana** | http://IP_VM:5601 |
| **MinIO Console** | http://IP_VM:9001 |
| **Mailhog** | http://IP_VM:8025 |
| **Elasticsearch API** | http://IP_VM:9200 |

---

## 📦 3. Installation

### 🔧 Prérequis

- Debian / Ubuntu / Rocky Linux  
- Docker + Docker Compose  
- Git  
- 4 Go RAM minimum (8 Go recommandé)

---

### 🚀 Installation complète

Clonez le dépôt :

```bash
git clone https://github.com/asepol/CyberRisk-Training-Lab.git
cd CyberRisk-Training-Lab
./setup.sh

```
Ce script :
- Démarre la stack Docker
- Configure Prometheus / Grafana / Kibana
- Génère les pages Wiki.js
- Configure le dashboard
- Remplace automatiquement IP_VM dans les TP

## 🧩 4. Structure du dépôt
CyberRisk-Training-Lab/
│
├── docker-lab/
│   ├── docker-compose.yml
│   ├── config-infra.sh
│   └── fluent-bit/
│       └── fluent-bit.conf
│
├── dashboard/
│   ├── index.html
│   ├── style.css
│   └── tp/
│       ├── tp1.html
│       ├── tp2.html
│       ├── ...
│       └── tp9.html
│
├── courses/
│   ├── 01_ISO27001_SMSI/
│   ├── 02_ISO27002/
│   ├── ...
│   └── 11_EBIOS_RM/
│
├── configure-dashboard.sh
├── setup.sh
└── README.md

## 🛠️ 5. Scripts inclus
✔ setup.sh --> Script principal : installe toute la plateforme.
✔ configure-dashboard.sh --> Remplace automatiquement IP_VM dans les TP HTML.
✔ config-infra.sh --> Configure : Prometheus, Grafana (datasource + dashboard), Kibana (index patterns), Wiki.js (génération des pages)

## 📚 6. Documentation pédagogique
Wiki.js contient :
- RGPD 🎯 Section “Futures Releases” formatée pour ton README
- NIS2 🎯 Section “Futures Releases” formatée pour ton README
- ISO 27001 🎯 Section “Futures Releases” formatée pour ton README
- ISO 27002 🎯 Section “Futures Releases” formatée pour ton README
- ISO 27005🎯 Section “Futures Releases” formatée pour ton README
- MEHARI 🎯 Section “Futures Releases” formatée pour ton README
- EBIOS RM 🎯 Section “Futures Releases” formatée pour ton README
- Gestion des incidents 🎯 Section “Futures Releases” formatée pour ton README
- PCA / PRA 🎯 Section “Futures Releases” formatée pour ton README
A importer manuellement
markdown
---

## 🚧 7. Futures Releases

Plusieurs améliorations sont prévues pour les prochaines versions du CyberRisk-Training-Lab :

### 🔄 Import automatique des cours dans Wiki.js
Actuellement, les pages pédagogiques (ISO 27001, NIS2, RGPD, EBIOS RM, etc.) sont générées dans le dossier :

wiki-content/

Code

Une future release ajoutera un **script d’automatisation** permettant :

- d’importer automatiquement toutes les pages dans Wiki.js  
- de créer l’arborescence complète des cours  
- de mettre à jour les pages existantes  
- de gérer les catégories et permissions  
- d’éviter toute manipulation manuelle dans l’interface Wiki.js  

Ce script utilisera l’API officielle de Wiki.js pour permettre une **synchronisation complète** entre le dépôt GitHub et le Wiki.

### 🧰 Autres évolutions prévues
- Ajout d’un script de **vérification de la stack** (healthcheck complet)  
- Ajout d’un script de **reset total** (containers + volumes + logs)  
- Ajout d’un **mode formateur** (accès avancé, monitoring, logs)  
- Ajout d’un **mode étudiant** (accès restreint, TP guidés)  
- Ajout d’un **dashboard Grafana avancé** pour la supervision du lab  
- Ajout d’un **schéma d’architecture visuel**  

Ces évolutions permettront de rendre la plateforme encore plus simple à utiliser, plus automatisée et plus adaptée à un usage pédagogique.
