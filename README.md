# BeDoHave Universal - Application Salesforce

![Logo BeDoHave Universal](https://orgfarm-a56bbd55d3-dev-ed.develop.my.salesforce.com/sfc/p/gL00000DUkfR/a/gL00000035hV/yQvFQY4MSveRRQrR9KxIpZz0wOVaHe56h4yz6GhCAJY)

## 1. Introduction

**BeDoHave Universal** est l'application Salesforce interne de l'entreprise **BeDoHave LLC**. Ce projet vise à digitaliser et à centraliser l'ensemble des processus métiers de l'entreprise, offrant une vue client à 360° et optimisant la gestion des opérations.

Ce référentiel contient l'intégralité du code source, de la configuration et de la documentation technique du projet.

* **Version Salesforce Cible :** Winter '26 (API v64.0)
* **Environnement :** Salesforce Developer Edition

## 2. Contexte Métier

BeDoHave LLC, dirigée par le CEO et conférencier **Simon OUEDRAOGO**, est une entreprise polyvalente basée au Burkina Faso, spécialisée dans :
* La communication et le développement personnel.
* L'écriture et la vente de livres (ex: "La puissance de l'auto éducation").
* La création et l'organisation de formations en ligne et en présentiel.
* L'organisation d'événements et de conférences (ex: GCAP).
* La gestion de plusieurs marques et services (The Nill, RichessMedia, My Glory, IMRIS).
* La publication de contenu sur les réseaux sociaux.

L'objectif est de gérer les interactions avec des milliers d'étudiants, clients et partenaires de manière unifiée et efficace.

## 3. Stack Technique

* **Backend :** Apex, SOQL, SOSL
* **Frontend :** Lightning Web Components (LWC) - (JavaScript, HTML, CSS)
* **Automatisation :** Flows, Process Builder, Triggers Apex
* **Développement & Déploiement :** Salesforce DX (SFDX), VS Code
* **Intégration Continue (CI/CD) :** GitHub Actions
* **Gestion de version :** Git & GitHub

## 4. Prérequis et Installation

Pour commencer à développer sur ce projet, suivez les étapes ci-dessous.

### Prérequis Logiciels

1.  **Git :** [Installer Git](https://git-scm.com/downloads)
2.  **Visual Studio Code (VS Code) :** [Installer VS Code](https://code.visualstudio.com/)
3.  **Salesforce CLI (sfdx) :** [Installer la CLI](https://developer.salesforce.com/tools/sfdxcli)
4.  **Salesforce Extension Pack** pour VS Code : À installer depuis la marketplace de VS Code.

### Configuration du Projet

1.  **Cloner le dépôt :**
    ```bash
    git clone [https://github.com/WERMI-19/bedohave]
    cd bedohave
    ```

2.  **Authentifier votre Organisation Salesforce :**
    Ouvrez la palette de commandes de VS Code (`Ctrl+Shift+P` ou `Cmd+Shift+P`) et lancez la commande :
    ```
    SFDX: Authorize an Org
    ```
    Suivez les instructions pour vous connecter à votre organisation de développement. N'oubliez pas de lui donner un alias simple (ex: `bedohave-dev`).

3.  **Déployer le code source :**
    Pour déployer les métadonnées présentes dans le dossier `force-app`, utilisez la commande suivante :
    ```bash
    sfdx force:source:deploy -p force-app/main/default -u [ALIAS_DE_VOTRE_ORG]
    ```
    *Ou, pour déployer en utilisant un `package.xml` spécifique :*
    ```bash
    sfdx force:source:deploy -x manifest/package.xml -u [ALIAS_DE_VOTRE_ORG]
    ```

## 5. Processus de Développement

### Stratégie de Branches

Nous utilisons une stratégie de branches simple inspirée de GitFlow :
* `main` : Contient le code de production. Directement déployable.
* `develop` : Branche d'intégration pour les nouvelles fonctionnalités.
* `feature/[nom-feature]` : Chaque nouvelle fonctionnalité est développée dans sa propre branche, créée à partir de `develop`.
* `bugfix/[nom-bug]` : Pour les corrections de bugs urgents.

### Qualité du Code

* **Conventions de nommage :** Nous suivons les meilleures pratiques Salesforce pour le nommage des objets, champs, et classes Apex.
* **Tests Apex :** Tout code Apex (Trigger, Classe) doit être accompagné d'une classe de test avec une couverture de code **minimale de 85%**. Les tests doivent couvrir les cas nominaux, les cas limites et les insertions en masse (bulk).
* **Commentaires :** Le code doit être clair, lisible et commenté lorsque la logique est complexe. Chaque classe et méthode Apex doit avoir un commentaire ApexDoc.

## 6. Modèle de Données

Le modèle de données est au cœur de l'application. Il est conçu pour être évolutif et centré sur le client. La documentation détaillée et le diagramme sont disponibles dans le dossier `/documentation` du projet.

## 7. Ressources Utiles

* [Site Officiel Richess Massife](https://richessemassife.com/)
* [Web Radio RichessMedia](https://www.richessmedia.info/)
* [Documentation Salesforce pour Développeurs](https://developer.salesforce.com/docs/)
* [Référence de la librairie de composants LWC](https://www.lightningdesignsystem.com/components/)