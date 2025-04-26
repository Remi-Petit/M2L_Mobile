import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/produit.dart';

class Modifier extends StatefulWidget {
  const Modifier({Key? key}) : super(key: key);

  @override
  State<Modifier> createState() => _ModifierState();
}

class _ModifierState extends State<Modifier> {
  late Future<Map<String, dynamic>> _produitFuture;

  final _formKey = GlobalKey<FormState>();

  // Contrôleurs
  final _nomController = TextEditingController();
  final _marqueController = TextEditingController();
  final _poidsController = TextEditingController();
  final _tailleController = TextEditingController();
  final _quantiteController = TextEditingController();
  final _prixController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final id = ModalRoute.of(context)!.settings.arguments;
    _produitFuture = Produit.getProduit(context, id);
  }

  bool _champsRemplis = false;

  void _remplirChamps(Map<String, dynamic> produit) {
    if (_champsRemplis) return; // éviter de re-remplir à chaque rebuild
    _nomController.text = produit['nom_produit'] ?? "";
    _marqueController.text = produit['marque_produit'] ?? "";
    _poidsController.text = produit['poids_produit'] ?? "";
    _tailleController.text = produit['taille_produit'] ?? "";
    _quantiteController.text = produit['quantite_produit'] ?? "";
    _prixController.text = produit['prix_produit'] ?? "";
    _champsRemplis = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Modifier le produit",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _produitFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 40),
                  const SizedBox(height: 10),
                  Text("Erreur : ${snapshot.error}"),
                ],
              ),
            );
          }
          if (snapshot.hasData) {
            _remplirChamps(snapshot.data!);
            final produit = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Header Card chouette
                  Padding(
                    padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 4),
                    child: Card(
                      color: Colors.indigo.shade100,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.shopping_bag, size: 36, color: Colors.indigo),
                        title: Text(
                          produit['nom_produit'] ?? "",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        subtitle: Text(
                          produit['marque_produit'] ?? "",
                          style: const TextStyle(fontSize: 15, color: Colors.indigo),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _myTextField(_nomController, "Nom*", Icons.label),
                          _myTextField(_marqueController, "Marque*", Icons.business),
                          _myTextField(_poidsController, "Poids", Icons.scale),
                          _myTextField(_tailleController, "Taille", Icons.straighten),
                          _myTextField(_quantiteController, "Quantité", Icons.format_list_numbered),
                          _myTextField(_prixController, "Prix", Icons.euro),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.save, color: Colors.white),
                              label: const Text("Enregistrer", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final reponse = await Produit.modifier(
                                    context,
                                    produit['id_produit'].toString(),
                                    _nomController.text,
                                    _marqueController.text,
                                    _poidsController.text,
                                    _tailleController.text,
                                    _quantiteController.text,
                                    _prixController.text,
                                  );
                                  if (reponse != null && reponse["success"] == true) {
                                    // Succès: dialog + retour sur pop
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                        title: const Text('Succès', style: TextStyle(fontWeight: FontWeight.bold)),
                                        content: const Text('Le produit a été modifié !'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop(); // ferme le dialog
                                              Navigator.of(context).pop(true); // retourne à l'écran précédent
                                            },
                                            child: const Text('OK', style: TextStyle(color: Colors.indigo)),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text("Erreur de modification"),
                                        backgroundColor: Colors.red.shade700,
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text("Pas de données"));
        },
      ),
      backgroundColor: Colors.indigo.shade50,
    );
  }

  Widget _myTextField(TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.indigo),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(color: Colors.indigo),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.indigo, width: 2),
          ),
        ),
        validator: (value) {
          if (label.contains("*") && (value == null || value.isEmpty)) {
            return "Ce champ est obligatoire";
          }
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    _nomController.dispose();
    _marqueController.dispose();
    _poidsController.dispose();
    _tailleController.dispose();
    _quantiteController.dispose();
    _prixController.dispose();
    super.dispose();
  }
}
