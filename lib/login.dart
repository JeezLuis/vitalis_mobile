// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:vitalis_mobile/Model/local_user.dart';
import 'package:vitalis_mobile/dashboard.dart';
import 'package:vitalis_mobile/utils.dart';
import 'package:vitalis_mobile/network.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


final TextEditingController emailController = TextEditingController();
final TextEditingController passController = TextEditingController();

class LoginInterface extends StatefulWidget {
  const LoginInterface({super.key});

  @override
  State<StatefulWidget> createState() => _LoginInterfaceState();
}

class _LoginInterfaceState extends State<LoginInterface> {

  ///Local user stored inside internal storage
  LocalUser localUser = LocalUser();

  _LoginInterfaceState();


  @override
  void initState() {
    checkFaceID();
    super.initState();
  }

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
                            //Title
                            Text(AppLocalizations.of(context)!.login.toLowerCase(),
                                style: const TextStyle(
                                    fontFamily: 'GLORIOUS',
                                    fontSize: 70,
                                    color: Colors.white,
                                    shadows: <Shadow>[Shadow(color: Colors.black38, offset: Offset(3.0, 3.0), blurRadius: 4.0)]
                                )
                            ),
                            //Mail field
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: AppLocalizations.of(context)!.mail
                              ),
                            ),
                            const Padding(padding: EdgeInsets.fromLTRB(0,30,0,0)),
                            //Password Field
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
                                    hintText: AppLocalizations.of(context)!.password
                                )
                            ),
                            const Padding(padding: EdgeInsets.fromLTRB(0,30,0,0)),
                            //Login Button
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
                                  alertError(AppLocalizations.of(context)!.err_missing_fields, context);
                                }
                                else{
                                  logUser(emailController.text, passController.text);
                                }
                              },
                              child: Text(AppLocalizations.of(context)!.login),
                            ),
                            //Back Button
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
                              child: Text(AppLocalizations.of(context)!.back),
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

  ///Log user into the application
  logUser(String email, String password) async {
    //Check if mail and password combinatgion exists
    var response = await logPatient(email, generateMd5(password));
    if(response.isEmpty){
      alertError(AppLocalizations.of(context)!.err_auth_fail, context);
    }
    else{
      //Save credentials locally
      localUser = await getLocalUser();
      if(localUser.mail != email){
        setLocalUser(LocalUser(mail: email, password: password, faceid: false, userkey: response.elementAt(0).userkey));
      }

      //Empty input texts
      emailController.text = '';
      passController.text = '';

      //Navigate to the main dashboard of the user
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardInterface(),
        ),

      );
    }
  }

  ///Checks if FaceID is enabled from [localUser.faceid], if so: logins with saved credentials
  void checkFaceID() async {
    LocalAuthentication localAuth = LocalAuthentication();

    localUser = await getLocalUser();
    if(localUser.faceid == true){
      var result = await authenticate(localAuth);
      if(result == true){
        logUser(localUser.mail!, localUser.password!);
      }
    }
  }
}


