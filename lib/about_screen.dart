import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'À propos de la Bibliothèque',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        height: 150,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Notre bibliothèque est un lieu de savoir, de culture et d’échange. Fondée avec la mission de promouvoir la lecture et l’accès à linformation pour tous, nous nous efforçons de fournir un environnement accueillant et stimulant pour les lecteurs de tous âges. Que vous soyez un étudiant, un chercheur, un professionnel ou un passionné de littérature, nous avons une vaste collection de livres, de ressources numériques et de services adaptés à vos besoins.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 20),
                      const ListTile(
                        leading: Icon(Icons.book, color: Color.fromARGB(255, 4, 4, 4)),
                        title: Text(
                          'Collection des livres',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Consulter les livres et pouvoir les emprunter facilement.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const ListTile(
                        leading: Icon(Icons.people, color: Color.fromARGB(255, 6, 6, 6)),
                        title: Text(
                          'Consulter l\'historique de vos emprunts.',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Vous rappeler les dates de retour.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const ListTile(
                        leading: Icon(Icons.chat, color: Color.fromARGB(255, 13, 13, 13)),
                        title: Text(
                          'Chatbot intelligent',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Utilisez notre chatbot pour obtenir de l\'aide rapidement.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 20),
                      const Text(
                        'Avantages de notre bibliothèque',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 16, 16, 15),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Accès à une vaste collection de livres, interface utilisateur intuitive, support utilisateur réactif.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
