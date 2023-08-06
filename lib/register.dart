import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vitalis_mobile/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                        //Register title
                        Text(AppLocalizations.of(context)!.registert.toLowerCase(),
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
                        //Password field
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
                        //Repeat password field
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
                                hintText: AppLocalizations.of(context)!.rpassword
                            )
                        ),
                        const Padding(padding: EdgeInsets.fromLTRB(0,30,0,0)),
                        //Register Button
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
                          child: Text(AppLocalizations.of(context)!.register),
                        ),
                        const Padding(padding: EdgeInsets.fromLTRB(0,30,0,0)),
                        //Back Button
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

  ///Register new user into the database
  registerUser(BuildContext context) async {
    //Check if all fields have been completed
    if(emailController.text.isEmpty || passController.text.isEmpty || reppassController.text.isEmpty) {
      alertError(AppLocalizations.of(context)!.err_missing_fields, context);
      return 0;
    }

    //Check that both passwords are the same
    if(passController.text != reppassController.text){
      alertError(AppLocalizations.of(context)!.err_pass_err, context);
      return 0;
    }

    //Check if password is safe
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    if (!regex.hasMatch(passController.text)) {
      alertError(AppLocalizations.of(context)!.err_pass_format, context);
      return 0;
    }

    // do not forget to call Backendless.initApp when your app initializes
    BackendlessUser user = BackendlessUser()
      ..email = emailController.text
      ..password = passController.text;

    await Backendless.userService.register(user).then((registeredUser) {
      //Clear all input fields
      emailController.text = '';
      passController.text = '';
      reppassController.text = '';

      // ignore: use_build_context_synchronously
      alertInfo(AppLocalizations.of(context)!.info_registered, context);
    }).catchError((error) {
      PlatformException platformException = error;
      switch (platformException.code) {
      //Wrong email format
        case "3040":
        // ignore: use_build_context_synchronously
          alertError(AppLocalizations.of(context)!.err_mail_format, context);
          break;
      //User yet registered
        case "3033":
        // ignore: use_build_context_synchronously
          alertError(AppLocalizations.of(context)!.err_user_exists, context);
          break;
        default:
          alertError(platformException.details, context);
          break;
      }
    });
  }
}


