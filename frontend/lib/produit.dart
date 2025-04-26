import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

  const ip = '127.0.0.1';
  const port = '8000';

class Produit {
  static Future<List> getAllProduits() async {
    try {
      var res = await http.get(Uri.parse('http://$ip:$port/api/listeproduit'));

      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        return Future.error("erreur serveur");
      }
    } catch (err) {
      return Future.error(err);
    }
  }

  static getIdProduit(BuildContext context, idProduit) async {
    try {
      print("getIdProduit : " + idProduit);
      Navigator.pushNamed(context, '/modifier', arguments: idProduit);
    } catch (err) {
      return Future.error(err);
    }
  }

  static Future<Map<String, dynamic>> getProduit(context, id) async {
    try {
      print("getProduit : " + id.toString());
      var res = await http.get(Uri.parse('http://$ip:$port/api/produit/$id'));
      if (res.statusCode == 200) {
        return Map<String, dynamic>.from(jsonDecode(res.body));
      } else {
        return Future.error("erreur serveur");
      }
    } catch (err) {
      return Future.error(err);
    }
  }


  static ajout(BuildContext context, nom_produit, marque_produit, poids_produit, taille_produit, quantite_produit, prix_produit) async{

    try{
      Map<String,dynamic> data= {"nom_produit":nom_produit,"marque_produit":marque_produit,"poids_produit":poids_produit,"taille_produit":taille_produit,"quantite_produit":quantite_produit,"prix_produit":prix_produit};
      var res = await http.get(
        Uri.parse('http://$ip:$port/api/ajoutProduit/$nom_produit/$marque_produit/$poids_produit/$taille_produit/$quantite_produit/$prix_produit'),
      );
      if(res.statusCode == 201){
        // Si ça ajoute pas
        Navigator.pushNamed(context, '/', arguments: res.body
        );
      }
      else{
        Navigator.pushNamed(context, '/liste');
      }

    }
    catch(err){
      return Future.error(err);
    }
  }

  static supprimer(BuildContext context, id) async {
    print('supprimer id : $id');
    try {
      var res = await http.get(Uri.parse(
          'http://$ip:$port/api/supprimerProduit/$id'));
      if (res.statusCode == 200) {
        Navigator.pushNamed(context, '/liste');
      } else {
        Navigator.pushNamed(context, '/');
      }
    } catch (err) {
      return Future.error(err);
    }
  }

  static Future<Map<String, dynamic>?> modifier(
  BuildContext context,
  String id,
  String nom,
  String marque,
  String poids,
  String taille,
  String quantite,
  String prix
  ) async {
    try {
      var res = await http.get(Uri.parse(
        'http://$ip:$port/api/modifierProduit/$id/$nom/$marque/$poids/$taille/$quantite/$prix'
      ));
      if (res.statusCode == 200) {
        return json.decode(res.body);  // Retourne la réponse
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur lors de la modification"))
        );
        return null;
      }
    } catch (err) {
      return Future.error(err);
    }
  }


}