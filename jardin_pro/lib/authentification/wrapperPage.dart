import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jardin_pro/authentification/login.dart';
import 'package:jardin_pro/pages/home-page.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green, // Définit l'arrière-plan en bleu
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              if (snapshot.data!.emailVerified) {
                return const HomePage();
              }
            } else {
              //return const VerifierEmail();
            }
            return const Login();
          }),
    );
  }
}
