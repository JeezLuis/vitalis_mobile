import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vitalis_mobile/login.dart';
import 'package:vitalis_mobile/register.dart';
import 'package:vitalis_mobile/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter'
      ),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
                padding: EdgeInsets.fromLTRB(0, 17, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                      child: const Text("ENTRAR"),
                    ),
                    const Padding(padding: EdgeInsets.all(5)),
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
                      child: const Text("REGISTRARSE"),
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

  login() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginInterface(),
      ),

    );
  }

  register() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterInterface(),
      ),

    );
  }
}
