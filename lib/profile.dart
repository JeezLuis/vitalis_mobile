import 'package:flutter/material.dart';
import 'package:vitalis_mobile/Model/Patient.dart';
import 'package:vitalis_mobile/settings.dart';
import 'package:vitalis_mobile/utils.dart';



class ProfileInterface extends StatefulWidget {
  final Patient patient;

  const ProfileInterface({super.key, required this.patient});

  @override
  State<StatefulWidget> createState() => _ProfileInterfaceState(patient);
}

class _ProfileInterfaceState extends State<ProfileInterface> {
  final Patient patient;

  _ProfileInterfaceState(this.patient);


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
                            child: Image.asset("assets/img/props/perfiltxt.png", height: 36,),
                        )
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsInterface(),
                          ),
                        );
                      },
                      child: Image.asset("assets/img/props/settings.png", height: 36,),
                    )
                  ],
                ),
              )
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(25,10,25,10),
            margin: const EdgeInsets.fromLTRB(0,20,0,0),
            decoration: BoxDecoration(
              color: HexColor("4ADFF7"),
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 7,
                  offset: Offset(2, 3),
                  spreadRadius: 0.5,
                ),
              ],
            ),
            child: Column(
              children: [
                const Text("ID PACIENTE:", style: TextStyle(fontSize: 15, color: Colors.white),),
                Text(patient.userkey, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),)
              ],
            ),
          )
        ],
      ),
    );
  }
}


