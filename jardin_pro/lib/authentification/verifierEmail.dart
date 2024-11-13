import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jardin_pro/authentification/wrapperPage.dart';

class VerifierEmail extends StatefulWidget {
  const VerifierEmail({super.key});

  @override
  State<VerifierEmail> createState() => _VerifierEmailState();
}

class _VerifierEmailState extends State<VerifierEmail> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    sendverifylink();

    // Vérifie périodiquement l'état de vérification de l'email
    timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      await FirebaseAuth.instance.currentUser!.reload();
      var user = FirebaseAuth.instance.currentUser;
      if (user != null && user.emailVerified) {
        timer.cancel();
        Get.offAll(() => DrawerPage());
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  sendverifylink() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification().then((value) {
      Get.snackbar(
        'Lien envoyé',
        'Un lien de vérification a été envoyé à votre email.',
        margin: const EdgeInsets.all(30),
        snackPosition: SnackPosition.BOTTOM,
      );
    });
  }

  reload() async {
    await FirebaseAuth.instance.currentUser!.reload();
    var user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified) {
      Get.offAll(() => DrawerPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vérification"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text(
            "Ouvrez votre email et cliquez sur le lien envoyé, puis changez votre mot de passe.",
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: reload,
        child: const Icon(Icons.restart_alt_rounded),
      ),
    );
  }
}
