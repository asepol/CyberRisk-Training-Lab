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



