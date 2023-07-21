import 'package:flutter/material.dart';
import 'package:vitalis_mobile/utils.dart';

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
        body:
            Stack(
              children: [
                const Positioned.fill(  //
                  child: Image(
                    image: AssetImage("assets/img/background/logregbg.png"),
                    fit : BoxFit.fitWidth,
                  ),
                ),
                SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25,0,25,0),
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
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
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Mail'
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
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: 'Password'
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
                              onPressed: () => logUser(),
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

  logUser() {}
}


