import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final String apiKey = 'e21099bc036648fc95662687977279de';

  // Configuration du modèle
  final String model = "GPT 4o mini Pro";
  final int outputLength = 512;
  final double temperature = 0.7;
  final double topP = 0.7;
  final int topK = 50;
  final double repetitionPenalty = 1.0;
final String apiUrl = 'https://api.aimlapi.com/chat/completions'; // Replace with the correct API endpoint


  void _sendMessage(String userMessage) async {
    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add({"sender": "user", "message": userMessage});
    });

    try {
      // Simulation d'une réponse basée sur les paramètres
      String response = await _generateResponse(userMessage);

      setState(() {
        _messages.add({"sender": "bot", "message": response});
      });
    } catch (e) {
      setState(() {
        _messages.add({"sender": "error", "message": "Erreur : $e"});
      });
    }
  }

  Future<String> _generateResponse(String prompt) async {
  try {
    // Prepare the request payload
    final Map<String, dynamic> payload = {
      "model": model, // Ensure the model name is correct and supported by the API
      "messages": [
        {
          "role": "user",
          "content": "hello bonjour sb7 khir",
        },
      ],
      "max_tokens": outputLength,
      "temperature": temperature,
      "top_p": topP,
    };

    // Make the POST request
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Authorization": "Bearer $apiKey", // Ensure this matches API's authentication method
        "Content-Type": "application/json",
      },
      body: jsonEncode(payload),
    );

    // Handle the response
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices']?[0]['message']['content'] ??
          "Aucune réponse reçue."; // Adjust to match the API response structure
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(
          "Erreur API: ${response.statusCode} - ${errorData['message'] ?? response.reasonPhrase}");
    }
  } catch (e) {
    // Handle errors
    throw Exception("Une erreur est survenue : $e");
  }
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
              backgroundColor: Colors.teal,
              child: Icon(Icons.android, color: Colors.white),
            ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isUser ? Colors.orangeAccent : Colors.teal,
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
        title: const Text('Votre assistant'),
        backgroundColor: Colors.teal,
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
                    backgroundColor: Colors.teal,
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
