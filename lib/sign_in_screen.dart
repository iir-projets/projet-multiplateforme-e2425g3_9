import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Si connexion réussie, naviguer vers la page d'accueil
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Erreur inconnue')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  ButtonStyle _elevatedButtonStyle(Color backgroundColor, Color textColor) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor, // Couleur de fond
      foregroundColor: textColor, // Couleur du texte
      textStyle: const TextStyle(fontSize: 16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    );
  }

  ButtonStyle _textButtonStyle(Color textColor) {
    return TextButton.styleFrom(
      foregroundColor: textColor, // Couleur du texte
      textStyle: const TextStyle(fontSize: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFF808000)], // Noir et vert olive
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ajout du logo
                Image.asset(
                  'assets/logo.png',
                  height: 200, // Hauteur du logo
                  width: 200,  // Largeur du logo
                ),
                const SizedBox(height: 20),
                const Text(
                  'THE INFINITE SHELF',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 10, 10, 10)),
                ),
                const Text(
                  'BIENVENUE',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)),
                ),
                const SizedBox(height: 20),
                // Champ email
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30), // Arrondi pour un effet ovale
                    ),
                    labelStyle: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                // Champ mot de passe
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30), // Arrondi pour un effet ovale
                    ),
                    labelStyle: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                // Bouton de connexion
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _signIn,
                        style: _elevatedButtonStyle(Colors.white, Colors.black),
                        child: const Text('Se connecter'),
                      ),
                const SizedBox(height: 10),
                // Bouton créer un compte
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  style: _textButtonStyle(Colors.black),
                  child: const Text('Créer un compte'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
