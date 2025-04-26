import 'package:flutter/material.dart';
import 'package:flutterapp/produit.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class Ajout extends StatefulWidget {
  const Ajout({ Key? key }) : super(key: key);

  @override
  State<Ajout> createState() => _AjoutState();
}

class _AjoutState extends State<Ajout> {
  bool isAPIcallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? nom_produit;
  String? marque_produit;
  String? poids_produit;
  String? taille_produit;
  String? quantite_produit;
  String? prix_produit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Nouveau produit"),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        backgroundColor: Colors.indigo.shade50,    // fond plus doux
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _AjoutUI(context),
          ),
          inAsyncCall: isAPIcallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _AjoutUI(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              _titleField("Nom :"),
              FormHelper.inputFieldWidget(
                context,
                "nom_produit",
                "Nom du produit",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    return "Le nom ne peut être vide";
                  }
                  return null;
                }, (onSaved) {
                  nom_produit = onSaved;
                },
                borderFocusColor: Colors.indigo,
                borderColor: Colors.indigo,
                textColor: Colors.indigo.shade900,
                hintColor: Colors.indigo.withOpacity(0.5),
                borderRadius: 13,
                showPrefixIcon: true,
                prefixIcon: Icon(Icons.shopping_bag, color: Colors.indigo),
                prefixIconPaddingLeft: 8,
              ),

              _titleField("Marque :"),
              FormHelper.inputFieldWidget(
                context,
                "marque_produit",
                "Marque du produit",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    return "La marque ne peut être vide";
                  }
                  return null;
                }, (onSaved) {
                  marque_produit = onSaved;
                },
                borderFocusColor: Colors.indigo,
                borderColor: Colors.indigo,
                textColor: Colors.indigo.shade900,
                hintColor: Colors.indigo.withOpacity(0.5),
                borderRadius: 13,
                showPrefixIcon: true,
                prefixIcon: Icon(Icons.local_offer, color: Colors.indigo),
                prefixIconPaddingLeft: 8,
              ),

              _titleField("Poids :"),
              FormHelper.inputFieldWidget(
                context,
                "poids_produit",
                "Poids du produit",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    return "Le poids ne peut être vide";
                  }
                  return null;
                }, (onSaved) {
                  poids_produit = onSaved;
                },
                borderFocusColor: Colors.indigo,
                borderColor: Colors.indigo,
                textColor: Colors.indigo.shade900,
                hintColor: Colors.indigo.withOpacity(0.5),
                borderRadius: 13,
                showPrefixIcon: true,
                prefixIcon: Icon(Icons.fitness_center, color: Colors.indigo),
                prefixIconPaddingLeft: 8,
              ),

              _titleField("Taille :"),
              FormHelper.inputFieldWidget(
                context,
                "taille_produit",
                "Taille du produit",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    return "La taille ne peut être vide";
                  }
                  return null;
                }, (onSaved) {
                  taille_produit = onSaved;
                },
                borderFocusColor: Colors.indigo,
                borderColor: Colors.indigo,
                textColor: Colors.indigo.shade900,
                hintColor: Colors.indigo.withOpacity(0.5),
                borderRadius: 13,
                showPrefixIcon: true,
                prefixIcon: Icon(Icons.straighten, color: Colors.indigo),
                prefixIconPaddingLeft: 8,
              ),

              _titleField("Quantité :"),
              FormHelper.inputFieldWidget(
                context,
                "quantite_produit",
                "Quantité du produit",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    return "La quantité ne peut être vide";
                  }
                  return null;
                }, (onSaved) {
                  quantite_produit = onSaved;
                },
                borderFocusColor: Colors.indigo,
                borderColor: Colors.indigo,
                textColor: Colors.indigo.shade900,
                hintColor: Colors.indigo.withOpacity(0.5),
                borderRadius: 13,
                showPrefixIcon: true,
                prefixIcon: Icon(Icons.confirmation_num, color: Colors.indigo),
                prefixIconPaddingLeft: 8,
              ),

              _titleField("Prix :"),
              FormHelper.inputFieldWidget(
                context,
                "prix_produit",
                "Prix du produit",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    return "Le prix ne peut être vide";
                  }
                  return null;
                }, (onSaved) {
                  prix_produit = onSaved;
                },
                borderFocusColor: Colors.indigo,
                borderColor: Colors.indigo,
                textColor: Colors.indigo.shade900,
                hintColor: Colors.indigo.withOpacity(0.5),
                borderRadius: 13,
                showPrefixIcon: true,
                prefixIcon: Icon(Icons.euro, color: Colors.indigo),
                prefixIconPaddingLeft: 8,
              ),

              const SizedBox(height: 30),

              Center(
                child: FormHelper.submitButton(
                  "Valider",
                  () {
                    dynamic validate = globalFormKey.currentState?.validate();
                    if (validate != null && validate) {
                      globalFormKey.currentState?.save();
                      Produit.ajout(
                        context,
                        nom_produit,
                        marque_produit,
                        poids_produit,
                        taille_produit,
                        quantite_produit,
                        prix_produit,
                      );
                    }
                  },
                  btnColor: Colors.indigo,
                  borderColor: Colors.indigo.shade700,
                  txtColor: Colors.white,
                  borderRadius: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleField(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 10, bottom: 2),
      child: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.indigo),
      ),
    );
  }
}
