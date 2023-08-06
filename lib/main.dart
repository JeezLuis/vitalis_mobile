import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:vitalis_mobile/login.dart';
import 'package:vitalis_mobile/register.dart';
import 'package:vitalis_mobile/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vitalis',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        fontFamily: 'Inter'
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('es'),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Background
          Container(
            alignment: Alignment.topCenter,
            child: Image.asset("assets/img/background/appbg.png"),
          ),
          SafeArea(child:
            Container(
              alignment: Alignment.topCenter,
              child:
                const Text("vitalis",
                  style: TextStyle(
                      fontFamily: 'GLORIOUS',
                      fontSize: 120,
                      color: Colors.white,
                      shadows: <Shadow>[Shadow(color: Colors.black38, offset: Offset(3.0, 3.0), blurRadius: 4.0)]
                  )
                ),
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.topCenter,
              height: 120,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 17, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Login Button
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: HexColor("246D78"),
                        textStyle: const TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.bold, fontSize: 14),
                        fixedSize: const Size(167, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        side: BorderSide(width: 3.0, color: HexColor("246D78")),
                        elevation: 0,
                      ),
                      onPressed: () => login(),
                      child: Text(AppLocalizations.of(context)!.login.toUpperCase()),
                    ),
                    const Padding(padding: EdgeInsets.all(5)),
                    //Register Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("246D78"),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.bold, fontSize: 14),
                        fixedSize: const Size(167, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () => register(),
                      child: Text(AppLocalizations.of(context)!.register.toUpperCase()),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  ///Opens login page
  login() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginInterface(),
      ),

    );
  }

  ///Opens register page
  register() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterInterface(),
      ),

    );
  }

  @override
  void initState() {
    super.initState();
    Backendless.initApp(
        applicationId: "8103F34C-99A5-D89A-FF38-4643CA0C6800",
        androidApiKey: "74E76082-055E-455F-9121-5FE3E020F2E9",
        iosApiKey: "F5B3CF1A-C6D5-49F4-AEEC-3F0D61E9C3E5");
  }
}
