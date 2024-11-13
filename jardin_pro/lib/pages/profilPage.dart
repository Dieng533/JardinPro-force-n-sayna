import 'package:flutter/material.dart'; // Import de la bibliothèque Flutter pour les widgets de l'interface utilisateur
import 'package:image_picker/image_picker.dart'; // Import pour la sélection d'images depuis la galerie ou l'appareil photo
import 'package:cloud_firestore/cloud_firestore.dart'; // Import pour utiliser Firestore pour le stockage de données
import 'dart:io'; // Import pour gérer les fichiers locaux, tels que les images

// Classe ProfilPage, un StatefulWidget permettant d'afficher et de modifier le profil d'un utilisateur
class ProfilPage extends StatefulWidget {
  final String profilName; // Nom du profil passé en paramètre

  const ProfilPage({super.key, required this.profilName}); // Constructeur de la classe

  @override
  _ProfilPageState createState() => _ProfilPageState(); // Création de l'état de la page ProfilPage
}

// Classe d'état pour ProfilPage, gérant l'interface et les interactions
class _ProfilPageState extends State<ProfilPage> {
  // Contrôleurs pour les champs de texte
  TextEditingController _nameController = TextEditingController();
  TextEditingController _expertiseController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _contactController = TextEditingController();

  // Variables pour l'image du profil
  File? _image; // Stocke l'image du profil sélectionnée
  final ImagePicker _picker = ImagePicker(); // Instance de ImagePicker pour choisir une image
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Instance de Firestore pour les opérations de stockage

  // Méthode d'initialisation de l'état
  @override
  void initState() {
    super.initState();
    _nameController.text = widget.profilName; // Remplit le champ nom avec le nom du profil
    _expertiseController.text = "Fonction"; // Valeur par défaut pour le champ expertise
    _locationController.text = "Ville"; // Valeur par défaut pour le champ localisation
    _contactController.text = "exemple-jardin-pro@gmail.com"; // Valeur par défaut pour le champ contact
  }

  // Libération des contrôleurs de texte quand le widget est détruit
  @override
  void dispose() {
    _nameController.dispose();
    _expertiseController.dispose();
    _locationController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  // Fonction pour choisir une image de la galerie
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery); // Sélectionne une image depuis la galerie
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Met à jour l'image du profil si une image est sélectionnée
      });
    }
  }

  // Fonction pour sauvegarder les modifications dans Firestore
  Future<void> _saveChanges() async {
    // Enregistrement des données dans la collection 'users' dans Firestore
    await _firestore.collection('users').doc(widget.profilName).set({
      'name': _nameController.text,
      'expertise': _expertiseController.text,
      'location': _locationController.text,
      'contact': _contactController.text,
    });

    print("Données enregistrées dans Firestore !"); // Message de confirmation dans la console
    if (_image != null) {
      print("Image: ${_image!.path}"); // Affichage du chemin de l'image dans la console
    }
  }

  // Widget pour créer un champ de texte éditable avec un bouton d'édition
  Widget _buildEditableField(String label, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12), // Marge interne
      margin: const EdgeInsets.symmetric(vertical: 5), // Marge externe entre les champs
      decoration: BoxDecoration(
        color: Colors.green[50], // Fond du champ en vert clair
        borderRadius: BorderRadius.circular(12), // Coins arrondis
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.08), // Ombre légère de couleur brune
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Champ de texte pour la saisie
          Expanded(
            child: TextField(
              controller: controller, // Contrôleur du champ de texte
              decoration: InputDecoration(
                labelText: label, // Etiquette du champ
                labelStyle: TextStyle(color: Colors.green[700]), // Couleur de l'étiquette
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Coins arrondis de la bordure
                  borderSide: BorderSide.none, // Pas de bordure visible
                ),
                fillColor: Colors.white, // Fond du champ de texte
                filled: true, // Remplir le champ de texte
              ),
            ),
          ),
          // Icône d'édition pour chaque champ
          IconButton(
            icon: Icon(Icons.edit, color: Colors.brown), // Icône d'édition brune
            onPressed: () {}, // Fonctionnalité d'édition personnalisée (vide ici)
          ),
        ],
      ),
    );
  }

  // Construction de l'interface utilisateur
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Couleur de fond blanche
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profil", // Titre de l'écran
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // Style du texte de l'AppBar
        ),
        backgroundColor: Colors.brown, // Couleur de fond de l'AppBar en marron foncé
        elevation: 0, // Suppression de l'ombre sous l'AppBar
      ),
      body: SingleChildScrollView( // Permet le défilement si le contenu dépasse la taille de l'écran
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Marge autour du contenu
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image de profil avec possibilité de sélection en cliquant
              GestureDetector(
                onTap: _pickImage, // Ouvre la galerie lorsqu'on appuie sur l'image
                child: CircleAvatar(
                  radius: 60, // Taille de l'image
                  backgroundColor: Colors.green[100], // Fond vert clair si aucune image n'est sélectionnée
                  backgroundImage: _image != null ? FileImage(_image!) : null, // Affiche l'image sélectionnée si présente
                  child: _image == null
                      ? Icon(Icons.camera_alt, size: 50, color: Colors.brown) // Icône caméra si aucune image
                      : null,
                ),
              ),
              SizedBox(height: 20), // Espace sous l'image
              // Nom du profil affiché en texte
              Text(
                "Photo Profil",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[00],
                ),
              ),
              SizedBox(height: 20),
              // Champs modifiables (Nom, Expertise, Localisation, Contact)
              _buildEditableField("Nom", _nameController),
              _buildEditableField("Expertise", _expertiseController),
              _buildEditableField("Localisation", _locationController),
              _buildEditableField("Contact", _contactController),
              SizedBox(height: 30),
              // Bouton pour sauvegarder les modifications
              ElevatedButton(
                onPressed: _saveChanges, // Sauvegarde les modifications dans firestore aprés clique du bouton
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: Text("Sauvegarder", style: TextStyle(fontSize: 22, color: Colors.white)), // Texte du bouton
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Couleur verte
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Coins arrondis du bouton
                  ),
                  shadowColor: Colors.brown.withOpacity(0.3), // Ombre sous le bouton
                  elevation: 6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
