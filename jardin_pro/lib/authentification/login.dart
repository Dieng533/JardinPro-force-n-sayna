import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jardin_pro/authentification/forgot.dart';
import 'package:jardin_pro/authentification/sign-in.dart';
import 'package:jardin_pro/pages/home-page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Contrôleurs pour capturer l'email et le mot de passe de l'utilisateur
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isloading = false; // Indicateur de chargement pendant la connexion
  bool isPasswordVisible = false; // Contrôle la visibilité du mot de passe

  // Fonction de connexion avec Firebase Authentication
  signIn() async {
    setState(() {
      isloading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      // Redirige vers la page d'accueil après une connexion réussie
      Get.offAll(() => HomePage()); // Efface la pile de navigation
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Erreur", e.code); // Affiche une erreur spécifique de Firebase
    } catch (e) {
      Get.snackbar("Erreur", e.toString()); // Affiche toute autre erreur
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return isloading
        ? const Center(child: CircularProgressIndicator()) // Indicateur de chargement
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.brown,
              centerTitle: true,
              title: const Text(
                "Connexion",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0), // Padding pour espacement
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo responsive
                  Image.asset(
                    'assets/logo.png',
                    width: screenWidth * 0.8, // Ajuste la taille en fonction de la largeur de l'écran
                    height: 250,
                  ),
                  SizedBox(height: 20),
                  
                  // Champ de saisie pour l'email
                  TextField(
                    controller: email,
                    textInputAction: TextInputAction.next,
                    cursorColor: Colors.green,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.9),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Entrer email',
                      prefixIcon: Icon(Icons.person, color: Colors.green),
                      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                      filled: true,
                      fillColor: Color(0xFFE0DCDC).withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Champ de saisie pour le mot de passe avec visibilité toggle
                  TextField(
                    controller: password,
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      hintText: 'Entrer mot de passe',
                      prefixIcon: Icon(Icons.lock, color: Colors.green),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                      filled: true,
                      fillColor: Color(0xFFE0DCDC).withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                      ),
                    ),
                    obscureText: !isPasswordVisible, // Masque le texte si non visible
                  ),
                  SizedBox(height: 10),

                  // Bouton "Mot de passe oublié"
                  TextButton(
                    onPressed: () => Get.to(Forgot()), // Redirige vers la page de récupération de mot de passe
                    child: const Text(
                      "Mot de passe oublié ?",
                      style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                    ),
                  ),

                  // Bouton de connexion
                  ElevatedButton(
                    onPressed: signIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Connexion",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 25),

                  // Lien d'inscription
                  Text.rich(
                    TextSpan(
                      text: "Si vous n'avez pas de compte, ",
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                      children: [
                        TextSpan(
                          text: "inscrivez-vous?",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(Signup()); // Redirige vers la page d'inscription
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
