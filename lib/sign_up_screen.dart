import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController(); // Controller pour le nom d'utilisateur
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController(); // Controller pour confirmer le mot de passe
  final _auth = FirebaseAuth.instance;

  Future<void> _signUp() async {
    if (_passwordController.text.trim() != _confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Les mots de passe ne correspondent pas.')),
      );
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Enregistrement du nom d'utilisateur dans le profil de l'utilisateur
      await _auth.currentUser?.updateDisplayName(_usernameController.text.trim());
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${e.toString()}')),
      );
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/logo.png',
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 20),
                // Titres
                const Text(
                  'THE INFINITE SHELF',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 3, 3, 3)),
                ),
                const Text(
                  'BIENVENUE',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 16, 15, 15)),
                ),
                const SizedBox(height: 20),
                // Champs de texte
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Nom d’utilisateur',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30), // Arrondir les bords
                    ),
                    labelStyle: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30), // Arrondir les bords
                    ),
                    labelStyle: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30), // Arrondir les bords
                    ),
                    labelStyle: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirmer le mot de passe',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30), // Arrondir les bords
                    ),
                    labelStyle: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                // Boutons
                ElevatedButton(
                  onPressed: _signUp,
                  style: _elevatedButtonStyle(Colors.white, Colors.black),
                  child: const Text('S’inscrire'),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/signin'),
                  style: _textButtonStyle(Colors.black),
                  child: const Text('Se connecter'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
