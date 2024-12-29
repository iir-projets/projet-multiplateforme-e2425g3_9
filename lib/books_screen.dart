import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'book_detail_screen.dart';

class Book {
  final String title;
  final String author;
  final String image;
  final String description;
  double rating;
  List<Comment> comments;

  Book({
    required this.title,
    required this.author,
    required this.image,
    required this.description,
    this.rating = 0.0,
    this.comments = const [],
  });
}

class Comment {
  final String user;
  final String text;
  final bool liked;

  Comment({required this.user, required this.text, this.liked = false});
}

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Méthode pour ajouter un livre dans Firestore
  void _addBook(String title, String author, String image, String description) async {
    CollectionReference books = FirebaseFirestore.instance.collection('books');

    try {
      await books.add({
        'title': title,
        'author': author,
        'image': image,
        'description': description,
        'rating': 0.0,
        'comments': [],
      });
      print('Livre ajouté avec succès');
    } catch (e) {
      print("Erreur lors de l'ajout du livre: $e");
    }
  }

  // Méthode pour supprimer un livre de Firestore
  void _removeBook(String bookId) async {
    try {
      await FirebaseFirestore.instance.collection('books').doc(bookId).delete();
      print('Livre supprimé avec succès');
    } catch (e) {
      print("Erreur lors de la suppression du livre: $e");
    }
  }

  // Affichage du dialog d'ajout de livre
  void _showAddBookDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController authorController = TextEditingController();
    final TextEditingController imageController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ajouter un nouveau livre'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Titre'),
                ),
                TextField(
                  controller: authorController,
                  decoration: const InputDecoration(labelText: 'Auteur'),
                ),
                TextField(
                  controller: imageController,
                  decoration: const InputDecoration(labelText: 'URL de l\'image de couverture'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
          
          ],
        );
      },
    );
  }

  // Afficher le formulaire d'emprunt
  void _showBorrowFormDialog(Book book) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController pickupDateController = TextEditingController();
    final TextEditingController returnDateController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Emprunter le livre'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nom complet'),
                ),
                TextField(
                  controller: pickupDateController,
                  decoration: const InputDecoration(labelText: 'Date de récupération'),
                  keyboardType: TextInputType.datetime,
                ),
                TextField(
                  controller: returnDateController,
                  decoration: const InputDecoration(labelText: 'Date de retour'),
                  keyboardType: TextInputType.datetime,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                final borrowerName = nameController.text;
                final pickupDate = pickupDateController.text;
                final returnDate = returnDateController.text;

                if (borrowerName.isNotEmpty && pickupDate.isNotEmpty && returnDate.isNotEmpty) {
                  try {
                    await FirebaseFirestore.instance.collection('emprunts').add({
                      'book_title': book.title,
                      'borrower_name': borrowerName,
                      'pickup_date': pickupDate,
                      'return_date': returnDate,
                    });
                    print('Emprunt enregistré avec succès');
                    Navigator.of(context).pop();
                  } catch (e) {
                    print("Erreur lors de l'enregistrement de l'emprunt: $e");
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 254, 253, 251),
              ),
              child: const Text('Emprunter'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Livres'),
      actions: [
        ElevatedButton.icon(
          onPressed: _showAddBookDialog,
          icon: const Icon(Icons.add),
          label: const Text('Ajouter'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 1, 1, 1),
          ),
        ),
      ],
    ),
    body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFF808000)], // Noir et vert olive
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('books').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Erreur lors de la récupération des livres"));
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("Aucun livre trouvé"));
            } else {
              var books = snapshot.data!.docs.map((doc) {
                return Book(
                  title: doc['title'],
                  author: doc['author'],
                  image: doc['image'],
                  description: doc['description'],
                  rating: doc['rating'].toDouble(),
                  comments: List<Comment>.from(doc['comments'].map((comment) => Comment(
                    user: comment['user'],
                    text: comment['text'],
                    liked: comment['liked'],
                  ))),
                );
              }).toList();

              return ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              book.image,
                              width: 100,
                              height: 150,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 100),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Auteur: ${book.author}',
                                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                                ),
                                const SizedBox(height: 10),
                                RatingBar.builder(
                                  initialRating: book.rating,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      book.rating = rating;
                                    });
                                  },
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  book.description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        _showBorrowFormDialog(book);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(255, 233, 235, 237),
                                      ),
                                      child: const Text('Emprunter'),
                                    ),
                                    const SizedBox(width: 10),
                                  
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    ),
  );
}}