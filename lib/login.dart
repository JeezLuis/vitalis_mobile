import 'package:flutter/material.dart';
import 'package:vitalis_mobile/utils.dart';
import 'package:vitalis_mobile/network.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passController = TextEditingController();

class LoginInterface extends StatefulWidget {
  const LoginInterface({super.key});


  @override
  State<StatefulWidget> createState() => _LoginInterfaceState();
}

class _LoginInterfaceState extends State<LoginInterface> {

  _LoginInterfaceState();


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
                            const Text("entrar",
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
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor("4ADFF7"),
                                foregroundColor: Colors.black,
                                textStyle: const TextStyle(fontSize: 18),
                                fixedSize: const Size(89, 47),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                if(emailController.text.isEmpty || passController.text.isEmpty){
                                  //TODO: Error
                                }
                                else{
                                  logUser(emailController.text, passController.text);
                                }
                              },
                              child: const Text("Entrar"),
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

  logUser(String email, String password) async {
    var response = await logPatient(email, generateMd5(password));
    if(response.isEmpty){
      //TODO: Error
      print("Error");
    }
    else{
      //TODO: Guardar el usuario en la memoria local
      emailController.text = '';
      passController.text = '';
      //TODO: Login
    }
  }
}


