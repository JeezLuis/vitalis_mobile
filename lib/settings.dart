import 'package:flutter/material.dart';
import 'package:vitalis_mobile/utils.dart';

class SettingsInterface extends StatefulWidget {
  const SettingsInterface({super.key});


  @override
  State<StatefulWidget> createState() => _SettingsInterfaceState();
}

class _SettingsInterfaceState extends State<SettingsInterface> {

  _SettingsInterfaceState();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Container(
              height: AppBar().preferredSize.height + 80,
              decoration: BoxDecoration(
                color: HexColor("246D78"),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 4,
                    blurRadius: 7,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10,0,10,29),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset("assets/img/props/back.png", height: 36,),
                    ),
                    Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Image.asset("assets/img/props/ajustestxt.png", height: 36,),
                        )
                    ),
                    const SizedBox(width: 36,height: 36,),
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}


