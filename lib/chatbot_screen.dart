import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  final Map<String, Map<String, String>> bookData = {
    "harry potter": {
      "auteur": "L'auteur de la série Harry Potter est J.K. Rowling, un pseudonyme utilisé par Joanne Rowling. Elle est une auteure britannique qui a créé l'univers magique de Harry Potter, qui a connu un immense succès mondial. La série comprend sept livres, le premier étant Harry Potter à l'école des sorciers, publié en 1997.",
      "résumé": "Un jeune sorcier découvre ses pouvoirs et lutte contre les forces du mal.",
      "avis": "Un classique moderne apprécié par les lecteurs de tous âges."
    },
    "le petit prince": {
      "auteur": "Antoine de Saint-Exupéry",
      "résumé": "Le Petit Prince est un conte philosophique écrit par Antoine de Saint-Exupéry. Il raconte l’histoire d’un jeune prince venu d’une petite planète, l'astéroïde B-612. Le narrateur, un aviateur, rencontre le prince dans le désert après un accident d'avion. Le prince lui raconte son voyage à travers différents mondes, où il rencontre divers personnages qui représentent des aspects de la société adulte, comme un roi, un vaniteux, un buveur, un allumeur de réverbères, un géographe, et un businessman, chacun symbolisant des comportements absurdes ou dénués de sens. Au cours de ses aventures, le prince apprend des leçons sur l’amour, l’amitié et la nature humaine. Il se lie d’amitié avec un renard, qui lui enseigne l’importance de l’apprivoisement, et il se souvient de sa rose, qu’il a laissée derrière lui sur sa planète. Cette rose, bien que semblable à d'autres, est unique pour lui car elle est la sienne. Le récit explore la distinction entre la vision des adultes, souvent pragmatique et matérialiste, et celle des enfants, plus pure et intuitive. Le livre se termine par une réflexion sur le sens de la vie, de la perte, et de l’amour. Le Petit Prince incite à voir le monde avec les yeux d’un enfant, en valorisant les choses essentielles invisibles aux yeux adultes.",
      "avis": "Un conte poétique et philosophique qui touche toutes les générations."
    }
  };

  void _sendMessage(String userMessage) {
    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add({"sender": "user", "message": userMessage});
    });

    String response = _generateResponse(userMessage);

    setState(() {
      _messages.add({"sender": "bot", "message": response});
    });
  }

  String _generateResponse(String prompt) {
    prompt = prompt.toLowerCase();

    // Réponses générales
    if (prompt.contains('bonjour')) {
      return 'Bonjour ! Comment puis-je vous aider aujourd’hui ?';
    } else if (prompt.contains('Aidez-moi')) {
      return 'Bien sûr ! Posez-moi des questions sur un livre ou autre chose.';
    } else if (prompt.contains('au revoir')) {
      return 'Au revoir ! Passez une excellente journée.';
    }

    // Réponses sur les livres
    for (var book in bookData.keys) {
      if (prompt.contains(book)) {
        final details = bookData[book]!;
        if (prompt.contains('auteur')) return ' ${details['auteur']}';
        if (prompt.contains('résumé')) return ' ${details['résumé']}';
        if (prompt.contains('avis')) return 'Avis : ${details['avis']}';
        return 'Vous avez mentionné "$book". Demandez-moi l’auteur, un résumé ou un avis.';
      }
    }

    // Réponse par défaut
    return 'Désolé, je n’ai pas compris. Pouvez-vous préciser votre demande ?';
  }

  Widget _buildMessage(Map<String, String> msg) {
    bool isUser = msg['sender'] == 'user';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser)
            const CircleAvatar(
              backgroundColor: Color.fromARGB(255, 6, 6, 6),
              child: Icon(Icons.android, color: Colors.white),
            ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isUser ? const Color.fromARGB(255, 181, 224, 82) : const Color.fromARGB(255, 6, 6, 6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                msg['message'] ?? '',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Votre Assistant'),
        backgroundColor: const Color.fromARGB(255, 5, 5, 5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) => _buildMessage(_messages[index]),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Entrez votre message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSubmitted: (text) {
                      _sendMessage(text);
                      _controller.clear();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _sendMessage(_controller.text);
                    _controller.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
