import 'package:flutter/material.dart';

class DetailPlantationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Détails de nos services",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView( // Ajout de SingleChildScrollView pour permettre le défilement
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const [
              ListTile(
                title: Text(
                  "Création Jardin",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.green,
                  ),
                ),
                subtitle: Text(
                  "Vous rêvez d'un jardin unique et personnalisé ? Nos experts en création de jardins vous accompagnent dans la conception et l'aménagement de votre espace extérieur. De la planification à la réalisation, nous vous proposons des solutions adaptées à vos envies et à votre budget pour transformer votre jardin en un lieu de détente et de beauté.",
                ),
              ),
              ListTile(
                title: Text(
                  "Entretien Pelouse",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.green,
                  ),
                ),
                subtitle: Text(
                  "Pour une pelouse verdoyante et saine, notre équipe d'experts en entretien de pelouse est à votre service. Tonte, fertilisation, désherbage et aération : nous proposons une gamme complète de services pour garder votre pelouse impeccable tout au long de l'année. Profitez d'un jardin toujours bien entretenu sans lever le petit doigt !",
                ),
              ),
              ListTile(
                title: Text(
                  "Taille des arbustes",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.green,
                  ),
                ),
                subtitle: Text(
                  "La taille régulière des arbustes est essentielle pour leur santé et leur apparence. Nos professionnels s'occupent de la taille de vos arbustes avec soin et précision, en respectant leur forme naturelle et en favorisant une croissance optimale. Confiez-nous vos végétaux et profitez d'un jardin harmonieux et bien entretenu.",
                ),
              ),
              ListTile(
                title: Text(
                  "Aménagement et Création de jardin",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.green,
                  ),
                ),
                subtitle: Text(
                  "Que vous souhaitiez créer un jardin paysager, une terrasse fleurie ou un jardin potager, nos experts en aménagement extérieur vous proposent des solutions sur mesure. Nous prenons en compte vos préférences esthétiques, les conditions du terrain et vos besoins pour créer un jardin fonctionnel, durable et magnifique.",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
