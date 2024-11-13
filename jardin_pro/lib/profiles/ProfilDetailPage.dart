import 'package:flutter/material.dart';
import 'package:jardin_pro/pages/recherchePage.dart'; // Importer la page de recherche pour pouvoir utiliser la classe Profil

// Classe pour afficher les détails d'un profil
class ProfilDetailPage extends StatelessWidget {
  final Profil profil; // Déclare une variable pour stocker le profil passé en paramètre

  const ProfilDetailPage({Key? key, required this.profil}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(profil.nom, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)), // Affiche le nom du professionnel dans la barre d'applications
        backgroundColor: Colors.green[700], // Couleur de la barre d'applications
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Arrière-plan de l'application
            fit: BoxFit.cover, // L'image couvre toute la page
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Applique un padding autour du contenu
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Aligne le texte à gauche
            children: [
              // Affichage de l'image de profil avec un effet décoratif
              Center(
                child: Container(
                  padding: EdgeInsets.all(4), // Espacement autour de l'image
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white, // Fond blanc autour de l'image
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 8,
                        offset: Offset(0, 3), // Ombre sous l'image
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 60, // Taille de l'image
                    backgroundImage: AssetImage(profil.imageUrl), // Chemin de l'image
                  ),
                ),
              ),
              SizedBox(height: 16), // Espacement entre l'image et le texte
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      profil.nom, // Affiche le nom du professionnel
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ), // Style du nom (grand et en gras)
                    ),
                    SizedBox(height: 8),
                    Text(
                      profil.specialite, // Affiche la spécialité du professionnel
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ), // Style du texte de spécialité
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16), // Espacement entre les éléments
              Divider(color: Colors.black38), // Ligne de séparation stylisée
              SizedBox(height: 16),
              Text(
                'Service: ${profil.service}', // Affiche le service proposé
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.brown,
                
                ), // Style du texte du service
              ),
              SizedBox(height: 16),
              Text(
                profil.description, // Affiche la description
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black45,
                ), // Style du texte de la description
              ),
              SizedBox(height: 16),
              Text(
                'Contact: ${profil.contact}', // Affiche le contact
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20), // Espacement avant le bouton de contact
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    print('Contacter ${profil.nom}...'); // Action pour le bouton
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text('Contacter', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),), // Texte du bouton
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
