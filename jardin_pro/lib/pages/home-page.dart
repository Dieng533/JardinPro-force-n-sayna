import 'package:flutter/material.dart';
import 'package:jardin_pro/pages/profilPage.dart';
import 'package:jardin_pro/pages/recherchePage.dart';
import 'package:jardin_pro/pages/reservationPage.dart';

// Déclaration de la classe HomePage qui est un widget d'état.
// Cette classe est l'écran principal de l'application.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// État de la page HomePage, avec une variable `_currentIndex` pour gérer l'index de la page courante.
class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Indice actuel de l'onglet sélectionné.

  @override
  Widget build(BuildContext context) {
    // Liste des pages affichées dans chaque onglet de la barre de navigation inférieure.
    final List<Widget> _tabs = [
      _buildHomeContent(context), // Page d'accueil avec le contenu de services
      const Recherchepage(), // Page de recherche
      const ReservationPage(professionalName: 'ReservationPage'), // Page de réservation
      const ProfilPage(profilName: 'ProfilPage'), // Page de profil
    ];

    return Scaffold(
      // Corps principal qui affiche le contenu de l'onglet actuellement sélectionné.
      body: _tabs[_currentIndex],
      // Barre de navigation en bas de l'écran
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex, // Définit l'index de l'élément sélectionné
        selectedItemColor: Colors.green, // Couleur de l'élément sélectionné
        unselectedItemColor: Colors.grey, // Couleur des éléments non sélectionnés
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Services"), // Onglet Services
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Recherche"), // Onglet Recherche
          BottomNavigationBarItem(icon: Icon(Icons.shop_rounded), label: "Réservation"), // Onglet Réservation
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"), // Onglet Profil
        ],
        // Change l'index actuel lorsqu'un utilisateur appuie sur un élément de la barre.
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  // Widget qui construit le contenu de la page d'accueil
  Widget _buildHomeContent(BuildContext context) {
    // Liste des services disponibles avec leurs informations (image, titre, description)
    final List<Map<String, String>> services = [
      {
        'image': 'assets/service-images/desherbase.jpg',
        'title': 'Création de jardins ',
        'description': 'Vous rêvez d\'un jardin unique et personnalisé ? Nos experts...',
      },
      {
        'image': 'assets/service-images/entrtien.jpg',
        'title': 'Entretien Pelouse',
        'description': 'Pour une pelouse verdoyante et saine, notre équipe d\'experts...',
      },
      {
        'image': 'assets/service-images/taille.jpg',
        'title': 'Taille des arbustes',
        'description': 'La taille régulière des arbustes est essentielle pour leur...',
      },
      {
        'image': 'assets/service-images/plantation.jpg',
        'title': 'Aménagement',
        'description': 'Que vous souhaitiez créer un jardin paysager, une ter...',
      },
    ];

    // Détermination du nombre de colonnes selon la largeur de l'écran.
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth < 600 ? 2 : 3;

    // Structure visuelle principale de la page d'accueil
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "JardinPro", // Titre de l'application
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nos Services', // Titre de la section des services
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Bienvenue sur JardinPro, l\'application qui vous permet de créer, entretenir et embellir votre jardin avec l\'aide de professionnels qualifiés',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25),
              // Affichage des services sous forme de grille.
              GridView.builder(
                shrinkWrap: true, // Ajuste la hauteur de la grille
                physics: NeverScrollableScrollPhysics(), // Empêche le défilement de la grille
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount, // Nombre de colonnes
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.75, // Ratio hauteur/largeur des éléments
                ),
                itemCount: services.length, // Nombre d'éléments dans la liste
                itemBuilder: (context, index) {
                  final service = services[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.15),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/DetailPlantationPage');
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Image.asset(
                                service['image']!,
                                height: 130,
                              ),
                            ),
                          ),
                          Text(
                            service['title']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            service['description']!,
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(height: 12),
                        ],
                      ),
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
