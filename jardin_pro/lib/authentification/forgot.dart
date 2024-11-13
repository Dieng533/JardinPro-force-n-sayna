import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  TextEditingController email = TextEditingController();

  reset() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.brown,
        title: Text("Mot de passe",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // TextField avec design
            TextField(
              controller: email,
              decoration: InputDecoration(
                hintText: 'Entrer email',
                hintStyle:
                    TextStyle(color: Colors.grey[500]), // Couleur de l'indice
                filled: true,
                fillColor: Colors.grey[200], // Couleur de fond
                contentPadding: EdgeInsets.symmetric(
                    vertical: 15, horizontal: 20), // Marge interne
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30), // Coins arrondis
                  borderSide: BorderSide.none, // Pas de bordure
                ),
                prefixIcon:
                    Icon(Icons.email, color: Colors.green), // Icône email
              ),
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),

            SizedBox(height: 20), // Espacement entre les widgets

            // Bouton avec design
            ElevatedButton(
              onPressed: () => reset(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Couleur de fond
                padding: EdgeInsets.symmetric(
                    vertical: 15, horizontal: 30), // Marge interne
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Coins arrondis
                ),
              ),
              child: Text(
                "Envoyer le lien",
                style: TextStyle(
                    fontSize: 18,fontWeight: FontWeight.bold ,color: Colors.white), // Style du texte
              ),
            ),
          ],
        ),
      ),
    );
  }
}
