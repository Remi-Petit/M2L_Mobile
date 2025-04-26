import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterapp/produit.dart';

class Affichage extends StatefulWidget {
  const Affichage({Key? key}) : super(key: key);

  @override
  State<Affichage> createState() => _AffichageState();
}

class _AffichageState extends State<Affichage> {
  late Future<List> _produitList;

  @override
  void initState() {
    super.initState();
    _loadProduits();
  }

  void _loadProduits() {
    _produitList = Produit.getAllProduits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Liste des produits",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.indigo,
        elevation: 2,
      ),
      body: Container(
        color: Colors.indigo.shade50,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: FutureBuilder<List>(
          future: _produitList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                  child: Text("Aucun produit trouvé.", style: TextStyle(fontSize: 20)));
            }
            final produits = snapshot.data!;
            return ListView.builder(
              itemCount: produits.length,
              itemBuilder: (context, i) {
                final prod = produits[i];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                prod['nom_produit'] ?? "",
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () async {
                                      await Produit.supprimer(
                                          context, prod['id_produit'].toString());
                                      setState(_loadProduits);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.amber),
                                    onPressed: () async {
                                      await Navigator.pushNamed(
                                          context, '/modifier',
                                          arguments: prod['id_produit'].toString());
                                      setState(_loadProduits);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          //Text("ID : ${prod['id_produit']}", style: TextStyle(color: Colors.grey[700])),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 10,
                            runSpacing: 6,
                            children: [
                              if (prod['marque_produit'] != null)
                                _miniInfo("Marque :", prod['marque_produit']),
                              if (prod['poids_produit'] != null)
                                _miniInfo("Poids :", prod['poids_produit']),
                              if (prod['taille_produit'] != null)
                                _miniInfo("Taille :", prod['taille_produit']),
                              if (prod['quantite_produit'] != null)
                                _miniInfo("Qté :", prod['quantite_produit']),
                              if (prod['prix_produit'] != null)
                                _miniInfo("Prix :", prod['prix_produit']),
                            ],
                          ),
                        ]),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.pushNamed(context, '/ajout');
          setState(_loadProduits);
        },
        label: const Text(
          "Ajouter",
          style: TextStyle(
            color: Colors.white,    // Texte en blanc
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,       // Icône en blanc
        ),
        backgroundColor: Colors.indigo,
        // (optionnel à partir de Flutter 3) foregroundColor: Colors.white,
      ),

    );
  }

  Widget _miniInfo(String label, String value) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.indigo.shade100.withOpacity(0.6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text("$label $value", style: const TextStyle(fontSize: 15)),
      );
}
