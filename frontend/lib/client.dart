import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

  const ip = 'localhost';
  const port = '8000';

class Client {

  static Future<List> getAllClients() async{
    print("test");
    try{
      var res = await http.get(Uri.parse('http://$ip:$port/api/listeclients'));
      print(res);
      if(res.statusCode == 200){
        return jsonDecode(res.body);
      }
      else{
        return Future.error("erreur serveur");
      }
    }
    catch(err){
      return Future.error(err);
    }
  }

  static Future<bool> Login(BuildContext context, email, password) async {
    try {
      final res = await http.get(
        Uri.parse("http://$ip:$port/api/verifConnexion/$email/$password"),
      );
      final data = jsonDecode(res.body);

      print(" le truc c'est ${data["result"]}");

      if (data["result"] == 'true' && data["admin"] == 'true') {
        Navigator.pushNamed(context, '/liste');
        return true;
      } else {
        // On retourne juste false, pas de navigation ici
        return false;
      }
    } catch (err) {
      return false; // En cas d'erreur réseau ou autre : false aussi
    }
  }

}