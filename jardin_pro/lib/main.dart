import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:jardin_pro/authentification/wrapperPage.dart';
import 'package:jardin_pro/detailService/detailServices.dart';
import 'package:jardin_pro/firebase_options.dart';
import 'package:jardin_pro/pages/profilPage.dart';
import 'package:jardin_pro/pages/reservationPage.dart';


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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JardinPro',
      home: DrawerPage(),
      routes: {
        
        '/DetailPlantationPage': (context) => DetailPlantationPage(),
        '/ReservationPage': (context) => ReservationPage(professionalName: '', ),
        '/ProfilPage': (context) => ProfilPage(profilName: '',),
      },
    );
  }
}
