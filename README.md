📘 CyberRisk Training Lab – Plateforme pédagogique de cybersécurité
Bienvenue dans CyberRisk-Training-Lab, une plateforme complète permettant d’enseigner et de pratiquer :

la gestion des risques

la conformité (ISO 27001, ISO 27002, ISO 27005, RGPD, NIS2…)

la cybersécurité offensive et défensive

la supervision (SIEM, logs, dashboards)

l’analyse d’incidents

la gestion documentaire (Wiki.js)

Ce laboratoire est conçu pour être simple à déployer, portable, et 100% automatisé grâce à Docker et aux scripts fournis.

🏗️ 1. Architecture générale
La plateforme repose sur une stack Docker complète :

Composant	Rôle
Nginx Dashboard	Interface principale pour accéder aux TP
DVWA	Application vulnérable pour tests d’attaque
Juice Shop	Application vulnérable OWASP
Nextcloud	Stockage collaboratif
MinIO	Stockage objet S3
Mailhog	Serveur SMTP de test
Prometheus	Monitoring
Grafana	Dashboards de supervision
Elasticsearch	Stockage des logs
Kibana	Visualisation des logs
Fluent Bit	Collecte des logs
Wiki.js	Documentation pédagogique
PostgreSQL	Base de données Wiki.js
Les réseaux Docker sont segmentés :

frontend

backend

dmz

🌐 2. URLs des services
Après installation, les services sont accessibles via l’IP de la VM :

Service	URL
Dashboard TP	http://IP_VM:8080
DVWA	http://IP_VM:8081
Nextcloud	http://IP_VM:8082
Wiki.js	http://IP_VM:8083
Juice Shop	http://IP_VM:3005
Grafana	http://IP_VM:3001
Kibana	http://IP_VM:5601
MinIO Console	http://IP_VM:9001
Mailhog	http://IP_VM:8025
Elasticsearch API	http://IP_VM:9200
📦 3. Installation
🔧 Prérequis
Debian / Ubuntu / Rocky Linux

Docker + Docker Compose

Git

4 Go RAM minimum (8 Go recommandé)

🚀 Installation automatique
Clonez le dépôt :

bash
git clone https://github.com/asepol/CyberRisk-Training-Lab.git
cd CyberRisk-Training-Lab
Lancez l’installation complète :

bash
./setup.sh
Ce script :

démarre la stack Docker

configure Prometheus / Grafana / Kibana

génère les pages Wiki.js

configure le dashboard

remplace automatiquement IP_VM dans les TP

🧩 4. Structure du dépôt
Code
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
🛠️ 5. Scripts inclus
✔ setup.sh
Script principal : installe toute la plateforme.

✔ configure-dashboard.sh
Remplace automatiquement IP_VM dans les TP HTML.

✔ config-infra.sh
Configure :

Prometheus

Grafana (datasource + dashboard)

Kibana (index patterns)

Wiki.js (génération des pages)

📊 6. Supervision & Logs
🔥 Fluent Bit → Elasticsearch → Kibana
Tous les conteneurs envoient leurs logs vers Fluent Bit, qui les transmet à Elasticsearch.

Kibana permet ensuite :

la recherche de logs

la création de dashboards

l’analyse d’incidents

📈 Prometheus → Grafana
Grafana est préconfiguré avec :

datasource Prometheus

dashboard de monitoring

🧪 7. Applications vulnérables
🕷️ DVWA
Pour apprendre les attaques web classiques.

🍊 Juice Shop
Application OWASP moderne, idéale pour :

XSS

injections

IDOR

CSRF

attaques API

📚 8. Documentation pédagogique
Wiki.js contient :

RGPD

NIS2

ISO 27001

ISO 27002

ISO 27005

MEHARI

EBIOS RM

Gestion des incidents

PCA / PRA

Les pages sont générées automatiquement dans :

Code
wiki-content/
🧹 9. Réinitialisation de la plateforme
Pour tout arrêter :

bash
cd docker-lab
docker compose down
Pour tout supprimer (volumes inclus) :

bash
docker compose down -v
🧪 10. Vérification de la stack
bash
docker ps
Vous devez voir tous les services en Up.

🎉 11. Auteur
Projet créé par asepol  
Contact : asepol4sec@proton.me

🚀 12. Licence
Libre d’utilisation dans un cadre pédagogique.
