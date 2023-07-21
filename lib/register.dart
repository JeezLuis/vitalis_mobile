import 'package:flutter/material.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25,0,25,0),
          child: Container(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
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
                TextField(
                      controller: reppassController,
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
                          hintText: 'Repeat Password'
                      )
                  ),
                const Padding(padding: EdgeInsets.fromLTRB(0,30,0,0)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor("F8CF72"),
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(fontSize: 18),
                    fixedSize: const Size(100, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => registerUser(),
                  child: const Text("Login"),
                ),
                //Register Button
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 18),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    emailController.text = '';
                    passController.text = '';
                    reppassController.text = '';
                    Navigator.pop(context);
                  },
                  child: const Text("Register"),
                ),
              ],
            ),
          ),
        ) 
      )
    );
  }

  registerUser() {}
}


