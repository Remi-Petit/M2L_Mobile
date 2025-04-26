import 'package:flutter/material.dart';
import 'package:flutterapp/client.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? errorMessage; // <-- Ajout du message d'erreur

  void clearError() {
    // Efface le message d'erreur quand l'utilisateur modifie un champ
    if (errorMessage != null) {
      setState(() => errorMessage = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF536dfe), Color(0xFF283593)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 22),
                  child: Form(
                    key: globalFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Connexion",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 29,
                            color: Colors.indigo,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 32),
                        FormHelper.inputFieldWidget(
                          context, 
                          "Email",
                          "Email",
                          (onValidateVal){
                            if(onValidateVal.isEmpty){
                              return "L'email ne peut être vide";
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(onValidateVal)) {
                              return "Entrez un email valide";
                            }
                            return null;
                          }, 
                          (onSaved){
                            email = onSaved;
                          },
                          onChange: (_) => clearError(),
                          borderFocusColor: Colors.indigo,
                          borderColor: Colors.indigo,
                          textColor: Colors.indigo.shade900,
                          hintColor: Colors.indigo.shade200,
                          borderRadius: 15,
                          showPrefixIcon: true,
                          prefixIcon: Icon(Icons.person, color: Colors.indigo),
                          prefixIconPaddingLeft: 8,
                        ),
                        const SizedBox(height: 12),
                        FormHelper.inputFieldWidget(
                          context, 
                          "Mot_de_passe", 
                          "Mot de passe", 
                          (onValidateVal){
                            if(onValidateVal.isEmpty){
                              return "Le mot de passe ne peut être vide";
                            }
                            return null;
                          }, 
                          (onSaved){
                            password = onSaved;
                          },
                          onChange: (_) => clearError(),
                          obscureText: hidePassword,
                          borderFocusColor: Colors.indigo,
                          borderColor: Colors.indigo,
                          textColor: Colors.indigo.shade900,
                          hintColor: Colors.indigo.shade200,
                          borderRadius: 15,
                          showPrefixIcon: true,
                          prefixIcon: Icon(Icons.lock, color: Colors.indigo),
                          prefixIconPaddingLeft: 8,
                          suffixIcon: IconButton(
                            icon: Icon(
                              hidePassword ? Icons.visibility_off : Icons.visibility,
                              color: Colors.indigoAccent,
                            ),
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          width: double.infinity,
                          child: FormHelper.submitButton(
                            "Connexion",
                            () async {
                              var validate = globalFormKey.currentState?.validate();
                              if (validate != null && validate) {
                                globalFormKey.currentState?.save();
                                // On attend le retour pour savoir si admin et/ou OK
                                bool isAdmin = await Client.Login(context, email, password);
                                if (!isAdmin) {
                                  setState(() {
                                    errorMessage = "identification, mot de passe ou privilège incorrect";
                                  });
                                }
                                // Sinon navigation automatique dans ta fonction Client.Login
                              }
                            },
                            btnColor: Colors.indigo,
                            borderColor: Colors.indigo.shade700,
                            txtColor: Colors.white,
                            borderRadius: 18,
                          ),
                        ),
                        // Message d’erreur sous le bouton
                        if (errorMessage != null) ...[
                          const SizedBox(height: 14),
                          Text(
                            errorMessage!,
                            style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                          )
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
