import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jardin_pro/authentification/wrapperPage.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signUp() async {
    // Renommez cette méthode
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar("Erreur", "Veuillez remplir tous les champs");
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Get.offAll(
          DrawerPage()); // Navigation vers la page principale après l'inscription
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = "Le mot de passe est trop faible.";
          break;
        case 'email-already-in-use':
          errorMessage = "L'adresse e-mail est déjà utilisée.";
          break;
        default:
          errorMessage = "Erreur : ${e.message}";
      }
      Get.snackbar("Erreur", errorMessage);
    } catch (e) {
      Get.snackbar("Erreur", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        centerTitle: true,
        title: const Text("Inscription",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: 'Votre prénom et nom',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Color(0xFFE0DCDC).withOpacity(0.3),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none))),
            ),
            SizedBox(height: 15),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: 'Entrer email',
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.green,
                  ),
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Color(0xFFE0DCDC).withOpacity(0.3),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none))),
            ),
            SizedBox(height: 15),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: 'Entrer mot de passe',
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.green,
                  ),
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Color(0xFFE0DCDC).withOpacity(0.3),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none))),
              obscureText: true, // Masquer le mot de passe
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: signUp, // Appel de la méthode signUp
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.green, // Définit la couleur de fond
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical:
                          10), // Optionnel : ajoute un padding pour ajuster la taille
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        30), // Optionnel : arrondit les coins du bouton
                  )),
              child: const Text(
                "Inscrire",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23,color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
