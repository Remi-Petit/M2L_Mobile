import 'package:flutter/material.dart';
import 'package:flutterapp/pages/Affichage.dart';
import 'package:flutterapp/pages/Ajout.dart';
import 'package:flutterapp/pages/Modifier.dart';
import 'package:flutterapp/pages/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'connection flutter et nodeJS via express',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/' : (context) => const LoginPage(),
        '/liste': (context) => const Affichage(),
        '/ajout': (context) => const Ajout(),
        '/modifier': (context) => const Modifier()
      },
    );
  }
}

