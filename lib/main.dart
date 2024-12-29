import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import pour Firebase Auth
import 'home_screen.dart';
import 'books_screen.dart';
import 'members_screen.dart';
import 'about_screen.dart';
import 'chatbot_screen.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';
import 'firebase_options.dart'; // Le fichier généré lors de la configuration Firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(0, 0, 0, 0)),
        useMaterial3: true,
      ),
      // Définir l'écran initial sur la page de connexion
      initialRoute: '/signin',
      routes: {
        '/signin': (context) => const SignInScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    BooksScreen(),
    MembersScreen(),
    ChatbotScreen(),
    AboutScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Fermer le tiroir après la sélection
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/signin'); // Retour à l'écran de connexion
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la déconnexion : ${e.toString()}')),

      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Library Management',
          style: TextStyle(color: Colors.black), // Texte noir pour contraster avec le fond blanc
        ),
        backgroundColor: Colors.white, // Fond blanc
        elevation: 0, // Supprimer l'ombre sous l'AppBar
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 10, 10, 10),
              ),
              accountName: Text(
                'THE INFINITE SHELF',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              accountEmail: Text(
                'Bibliothèque publique',
                style: TextStyle(fontSize: 16),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/logo.png'),
              ),
            ),
            const ListTile(
              leading: CircleAvatar(backgroundImage: AssetImage('assets/photo.png')),
              title: Text(
                'Rim Belabadia',
                style: TextStyle(fontSize: 15),
              ),
              subtitle: Text(
                'Adhérante',
                style: TextStyle(fontSize: 13),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.home),
              trailing: const Icon(Icons.arrow_forward),
              title: const Text('Accueil'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              trailing: const Icon(Icons.arrow_forward),
              title: const Text('Livres'),
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              trailing: const Icon(Icons.arrow_forward),
              title: const Text('Historique'),
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              trailing: const Icon(Icons.arrow_forward),
              title: const Text('Chatbot'),
              onTap: () => _onItemTapped(3),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              trailing: const Icon(Icons.arrow_forward),
              title: const Text('À propos'),
              onTap: () => _onItemTapped(4),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              trailing: const Icon(Icons.arrow_forward),
              title: const Text('Déconnexion'),
              onTap: _logout, // Appeler la méthode de déconnexion
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
