import 'package:flutter/material.dart';
import 'package:vitalis_mobile/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
                padding: const EdgeInsets.fromLTRB(10,0,10,10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset("assets/img/props/back.png", height: 36,),
                      ),
                    ),
                    Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text( AppLocalizations.of(context)!.settings_title,
                              style: const TextStyle(
                                  fontFamily: 'GLORIOUS',
                                  fontSize: 40,
                                  color: Colors.white,
                                  shadows: <Shadow>[Shadow(color: Colors.black38, offset: Offset(3.0, 3.0), blurRadius: 4.0)]
                              )
                          ),


                          //Image.asset("assets/img/props/ajustestxt.png", height: 36,),
                        )
                    ),
                    const SizedBox(width: 36,height: 36,),
                  ],
                ),
              )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40,top: 20),
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 20)),
                GestureDetector(
                  //TODO: Activar FaceID
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(Icons.fingerprint_outlined, size: 40,),
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      Text(AppLocalizations.of(context)!.settings_faceid_enable, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 32),),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(Icons.language_outlined, size: 40,),
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      Text(AppLocalizations.of(context)!.settings_language, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 32),),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                GestureDetector(
                  onTap: () {Navigator.of(context).popUntil((route) => route.isFirst);},
                  child: Row(
                    children: [
                      const Icon(Icons.logout_outlined, size: 40,),
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      Text(AppLocalizations.of(context)!.settings_exit, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 32),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


