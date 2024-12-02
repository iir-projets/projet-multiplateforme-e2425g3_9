# *Library Management App*  

## 📚 *Description*  
Library Management App est une application mobile développée avec *Flutter* pour gérer les opérations courantes d'une bibliothèque, telles que :  
- La gestion des livres (ajout, modification, suppression).  
- La gestion des utilisateurs (emprunts, retours).  
- La recherche et le filtrage des livres disponibles.  

[ Prototype du design " Library Management " ]
![WhatsApp Image 2024-11-30 à 10 05 07_45b07862](https://github.com/user-attachments/assets/ea776d01-fa08-4e68-8cb0-1eb1db7adb79)


![WhatsApp Image 2024-11-30 à 10 05 23_f76a834c](https://github.com/user-attachments/assets/8c251bd1-f3c8-4c4f-bb84-646320facad2)


## 🛠 *Fonctionnalités*  
### *Pour les utilisateurs :*  
- Consultation des livres disponibles avec leurs détails (titre, auteur, disponibilité).  
- Recherche et filtrage des livres par catégorie, auteur, ou titre.  
- Emprunt et retour de livres.  
- Historique des emprunts.  

### *Pour les bibliothécaires :*  
- Ajout, modification et suppression des livres.  
- Gestion des quantités et des stocks.  
- Notifications pour les emprunts en retard.  

---

## 🚀 *Technologies utilisées*  
### *Frontend :*  
- Flutter (Dart)  
- Material Design pour l’interface utilisateur  

### *Backend :*  
- Firebase pour l’authentification et la base de données.  
- Intégration des services REST (optionnel).  

---

## 📦 *Installation*  
1. Clonez ce dépôt sur votre machine locale :  
   bash  
   git clone https://github.com/nom-utilisateur/library-management-app.git  
     

2. Installez les dépendances nécessaires :  
   bash  
   flutter pub get  
     

3. Lancez l'application sur un émulateur ou un appareil physique :  
   bash  
   flutter run  
     

---

## 📋 *Structure du projet*  
Voici une vue simplifiée de l’architecture du projet :  

lib/  
├── models/         # Classes pour les modèles de données (Livre, Utilisateur, etc.).  
├── screens/        # Écrans principaux (Accueil, Catalogue, Emprunts).  
├── services/       # Services pour Firebase ou les appels API REST.  
├── widgets/        # Widgets réutilisables (boutons, cartes, etc.).  
└── main.dart       # Point d’entrée de l’application.  
  

---

## 🗂 *Fonctionnalités futures*  
- Gestion des rôles avancée (ex : administrateurs).  
- Notifications push pour les rappels d’emprunts.  
- Multilingue (anglais, français, etc.).  
- Mode hors ligne avec synchronisation automatique.  

---

## 👩‍💻 *Contributeurs*  
- *Rim Belabadia*
- *Rim Dighali*
- *Basma Boukhal*
- *Haytam Aatita*
- *Ahmad Warid*
  Étudiante en MIAGE et développeuse principale du projet.  

Pour toute suggestion ou contribution, veuillez contacter :  
📧 *rimbelabadia1234@gmail.com*  

---

## 📜 *Licence*  
Ce projet est sous licence [MIT](https://opensource.org/licenses/MIT). Vous êtes libre de l’utiliser et de le modifier en mentionnant l’auteur origine.
