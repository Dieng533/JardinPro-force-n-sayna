import 'package:flutter/material.dart';
import 'package:jardin_pro/profiles/ProfilDetailPage.dart'; // Importer la page de détails du profil

// Définition de la classe Profil pour stocker les informations sur chaque professionnel
class Profil {
  final String nom; // Nom du professionnel
  final String specialite; // Spécialité du professionnel
  final String description; // Description du professionnel
  final String service; // Service proposé par le professionnel
  final String imageUrl; // URL de l'image de profil du professionnel
  final String contact; // Numéro de contact du professionnel

  Profil({
    required this.nom,
    required this.specialite,
    required this.description,
    required this.service,
    required this.imageUrl,
    required this.contact,
  });
}

class Recherchepage extends StatefulWidget {
  const Recherchepage({super.key});

  @override
  State<Recherchepage> createState() => _RecherchepageState();
}

class _RecherchepageState extends State<Recherchepage> {
  // Liste des profils disponibles
  List<Profil> profils = [
    Profil(
        nom: "Maguette Dieng",
        specialite: "Ingénieur paysagiste",
        description:
            "Spécialiste de l'aménagement extérieur, qui conçoit des espaces paysagers fonctionnels et esthétiques. L'ingénieur paysagiste est responsable de la conception globale, de l'intégration des éléments naturels (plantes, arbres, etc.) et de l'adaptation du projet au terrain.",
        service: "Création Jardin",
        imageUrl: "assets/profils/assane.jpg",
        contact: "77 200 00 22"),
    Profil(
        nom: "Jean Fulgene Barraye",
        specialite: "Technicien en entretien des espaces verts",
        description:
            "Professionnel en charge de la tonte, de la fertilisation, du désherbage et de l'entretien général des pelouses. Il possède des compétences en matière de traitement des sols et des plantes, et est formé pour utiliser des outils spécialisés pour un entretien efficace.",
        service: "Entretien de la Pelouse",
        imageUrl: "assets/profils/jean.jpg",
        contact: "77 333 33 33"),
    Profil(
        nom: "Marie Faye",
        specialite: "Technicien arboricole",
        description:
            "Expert dans la gestion et la taille des arbres et des arbustes. Il est formé à la taille spécifique pour chaque espèce afin d'optimiser leur forme, leur santé et leur croissance.",
        service: "Taille des arbustes",
        imageUrl: "assets/profils/marie.jpg",
        contact: "76 258 22 22"),
    Profil(
        nom: "Ousmane Diop",
        specialite: "Ingénieur en aménagement du territoire",
        description:
            " Ce spécialiste de la planification et de l'aménagement des espaces extérieurs gère l'intégration du jardin dans son environnement global (urbanisme, écologie, climat, etc.).",
        service: "Aménagement de jardin",
        imageUrl: "assets/profils/ousmane.jpg",
        contact: "70 555 55 55"),
    Profil(
        nom: "Bouba Thioune",
        specialite: "Architecte d'extérieur",
        description:
            "pécialiste de la conception de l'espace extérieur, y comprenant des éléments structurels (terrains, murets, pergolas, fontaines) et des aspects esthétiques du jardin. Il travaille en collaboration avec des paysagistes et d'autres experts.",
        service: "Aménagement de jardin",
        imageUrl: "assets/profils/bouba.jpg",
        contact: "78 600 00 11"),
    // Ajoutez d'autres profils si nécessaire
  ];

  List<Profil> filteredProfils =
      []; // Liste pour stocker les profils filtrés selon la recherche
  String searchTerm = ''; // Terme de recherche entré par l'utilisateur

  @override
  void initState() {
    super.initState();
    filteredProfils =
        profils; // Initialiser la liste filtrée avec tous les profils
  }

  // Fonction pour filtrer les profils en fonction du terme de recherche
  void _filterProfils(String term) {
    setState(() {
      searchTerm = term; // Mettre à jour le terme de recherche
      // Filtrer les profils par nom ou service en fonction du terme de recherche
      filteredProfils = profils
          .where((profil) =>
              profil.nom.toLowerCase().contains(term.toLowerCase()) ||
              profil.service.toLowerCase().contains(term.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Couleur de fond de la page
      appBar: AppBar(
        backgroundColor: Colors.brown, // Couleur de la barre d'applications
        centerTitle: true,
        title: Text("Page Recherche",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white)), // Titre de la page
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Marges autour du contenu
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  onChanged:
                      _filterProfils, // Appeler la fonction de filtrage lors de la saisie
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                    hintText:
                        'Rechercher un profil ou un service', // Texte d'indice
                    labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.green.withOpacity(0.9),

                    prefixIcon:
                        Icon(Icons.search, size: 30.0), // Icône de recherche
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                            Icons.clear)), // Icône pour effacer la recherche
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Liste des profils filtrés
              ListView.builder(
                shrinkWrap:
                    true, // Permet de prendre la place nécessaire sans faire défiler
                physics:
                    NeverScrollableScrollPhysics(), // Désactiver le défilement
                itemCount:
                    filteredProfils.length, // Nombre d'éléments à afficher
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5, // Ombre de la carte
                    color: Colors.green, // Couleur de fond de la carte
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Coins arrondis
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0), // Marges internes
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                            filteredProfils[index].imageUrl), // Image de profil
                        radius: 30, // Rayon de l'avatar
                      ),
                      title: Text(
                        filteredProfils[index].nom,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white), // Style du nom
                      ),
                      subtitle: Text(
                        '${filteredProfils[index].specialite} - ${filteredProfils[index].service}', // Spécialité et service
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.brown), // Style de la sous-titre
                      ),
                      // Navigation vers la page de détails du profil
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilDetailPage(
                                profil: filteredProfils[
                                    index]), // Passage des données au profil détaillé
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
