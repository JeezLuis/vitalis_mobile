import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:vitalis_mobile/network.dart';
import 'package:vitalis_mobile/utils.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passController = TextEditingController();
final TextEditingController reppassController = TextEditingController();



class RegisterInterface extends StatefulWidget {
  const RegisterInterface({super.key});


  @override
  State<StatefulWidget> createState() => _RegisterInterfaceState();
}

class _RegisterInterfaceState extends State<RegisterInterface> {

  _RegisterInterfaceState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('246D78'),
        body:
        Stack(
          children: [
            Positioned(
              width: MediaQuery.of(context).size.width,
              top: MediaQuery.of(context).size.height*0.25,
              child: const Image(
                image: AssetImage("assets/img/background/logobg.png"),
              ),
            ),
            SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25,0,25,0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.fromLTRB(0,30,0,0)),
                        const Text("registro",
                            style: TextStyle(
                                fontFamily: 'GLORIOUS',
                                fontSize: 70,
                                color: Colors.white,
                                shadows: <Shadow>[Shadow(color: Colors.black38, offset: Offset(3.0, 3.0), blurRadius: 4.0)]
                            )
                        ),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Correo'
                          ),
                        ),
                        const Padding(padding: EdgeInsets.fromLTRB(0,30,0,0)),
                        TextField(
                            controller: passController,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Contraseña'
                            )
                        ),
                        const Padding(padding: EdgeInsets.fromLTRB(0,30,0,0)),
                        TextField(
                            controller: reppassController,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Repetir Contraseña'
                            )
                        ),
                        const Padding(padding: EdgeInsets.fromLTRB(0,30,0,0)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor("4ADFF7"),
                            foregroundColor: Colors.black,
                            textStyle: const TextStyle(fontSize: 18),
                            fixedSize: const Size(110, 47),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () => registerUser(context),
                          child: const Text("Registrar"),
                        ),
                        //Register Button
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 18),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            emailController.text = '';
                            passController.text = '';
                            reppassController.text = '';
                            Navigator.pop(context);
                          },
                          child: const Text("Atrás"),
                        ),
                      ],
                    ),
                  ),
                )
            ),
          ],
        )
    );
  }

  registerUser(BuildContext context) async {
    //Check if all fields have been completed
    if(emailController.text.isEmpty || passController.text.isEmpty || reppassController.text.isEmpty) {
      alertError("Por favor, rellena todos los campos", context);
      return 0;
    }

    //Check that both passwords are the same
    if(passController.text != reppassController.text){
      alertError("La constraseña no coincide", context);
      return 0;
    }

    //Check if password is safe
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    if (!regex.hasMatch(passController.text)) {
      alertError("La constraseña no valida, debe tener al menos una mayuscula, una minuscula, un digito y 8 caracteres.", context);
      return 0;
    }

    //Send POST method
    var response = await registerPatient(emailController.text, generateMd5(passController.text));
    if (response.statusCode == 200) {
      emailController.text = '';
      passController.text = '';
      reppassController.text = '';
      alertInfo("¡Se ha registrado correctamente!", context);
    } else {
      switch(jsonDecode(response.body)['code']){
        //Wrong email format
        case 8023:
          alertError("El formato de la dirección de correo es incorrecto.", context);
          break;
        //User yet registered
        case 1155:
          alertError("Usuario ya registrado", context);
          break;
      }
    }
  }
}


