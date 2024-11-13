import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationPage extends StatefulWidget {
  final String professionalName;

  const ReservationPage({
    Key? key,
    required this.professionalName,
  }) : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String _selectedService = 'Création de jardins';
  final List<String> _services = [
    'Création de jardins',
    'Entretien de la pelouse',
    'Taille des arbustes',
    'Aménagement complet',
  ];

  Future<void> _saveReservation() async {
    // Vérification des champs obligatoires
    if (_phoneController.text.isEmpty || _selectedService.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text("Veuillez remplir tous les champs sont obligatoires")),
      );
      return; // Arrêt de la fonction si des champs sont vides
    }

    try {
      // Enregistre la réservation dans Firestore
      await FirebaseFirestore.instance.collection('reservations').add({
        'professionalName': widget.professionalName,
        'service': _selectedService,
        'phone': _phoneController.text,
        'notes': _notesController.text,
        'date': FieldValue.serverTimestamp(),
      });

      // Affiche un message de succès
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirmation'),
          content: Text('Votre réservation a été envoyée avec succès!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text("Erreur lors de l'enregistrement de la réservation.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Réservation',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Center(
              child: Text(
                'Réserver votre service',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,),
              ),
            ),
            SizedBox(height: 16),
            // Text(
            //   'Service: $_selectedService',
            //   style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            // ),
            SizedBox(height: 12),
            Divider(color: Colors.grey[400]),

            // Champ de téléphone
            SizedBox(height: 16),
            Text(
              'Numéro de téléphone',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown),
            ),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Entrez votre numéro de téléphone',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Color(0xFFE0DCDC).withOpacity(0.3),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),

            // Sélecteur de service
            SizedBox(height: 16),
            Text(
              'Sélectionnez votre service',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown),
            ),
            DropdownButtonFormField<String>(
              value: _selectedService,
              items: _services.map((service) {
                return DropdownMenuItem(
                  value: service,
                  child: Text(service),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedService = value!;
                });
              },
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Color(0xFFE0DCDC).withOpacity(0.3),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),

            // Champ de notes supplémentaires
            SizedBox(height: 16),
            Text(
              'Notes supplémentaires',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown),
            ),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Ajouter des informations supplémentaires...',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Color(0xFFE0DCDC).withOpacity(0.3),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),

            SizedBox(height: 16,),
            Center(
              child: ElevatedButton(
                onPressed: _saveReservation,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  backgroundColor: Colors.green[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Confirmer la réservation',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
