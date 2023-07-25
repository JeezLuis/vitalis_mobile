import 'package:flutter/material.dart';
import 'package:vitalis_mobile/Model/LocalUser.dart';
import 'package:vitalis_mobile/profile.dart';
import 'package:vitalis_mobile/therapy.dart';
import 'package:vitalis_mobile/utils.dart';
import 'package:vitalis_mobile/network.dart';

import 'Model/Patient.dart';
import 'Model/TreatmentToPatient.dart';

class DashboardInterface extends StatefulWidget {
  const DashboardInterface({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardInterfaceState();
}

class _DashboardInterfaceState extends State<DashboardInterface> {

  LocalUser localUser = const LocalUser(mail: null, password: null, faceid: null, userkey: null);
  bool hasData = false;
  Patient patient = const Patient(userid: 0, userkey: '', mail: '', password: '', objectid: null, name: null, surnames: null, birthdate: null, gender: null, occupation: null, civilstate: null);
  List<TreatmentToPatient> treatments = <TreatmentToPatient>[];

  _DashboardInterfaceState();

  @override
  void initState() {
    initUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                    height: hasData == false ? AppBar().preferredSize.height + 45 + 80 : AppBar().preferredSize.height + 80,
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
                          const SizedBox(width: 36,height: 36,),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Image.asset("assets/img/props/logobanner.png", height: 30,))),
                          GestureDetector(
                            onTap: () {
                              showProfile(context);
                            },
                            child: Image.asset("assets/img/props/profile.png", height: 36,),
                          )
                        ],
                      ),
                    )
                ),
                treatments.isEmpty ? const Padding(
                    padding: EdgeInsets.fromLTRB(20,30,20,0),
                    child: Text("Sin tratamientos")
                )
                    :
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: treatments.length,
                      itemBuilder: (BuildContext context, int index){
                        TreatmentToPatient item = treatments[index];

                        return GestureDetector(
                          onTap: () {
                            showTreatment(item);
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 25, 20, 25),
                            margin: const EdgeInsets.fromLTRB(15,0,15,20),
                            decoration: BoxDecoration(
                              color: item.state == false ? HexColor("4ADFF7") : HexColor("8E8E8E"),
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 7,
                                  offset: Offset(2, 3),
                                  spreadRadius: 0.5,
                                ),
                              ],
                            ),
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.title!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                    const Padding(padding: EdgeInsets.only(top: 2)),
                                    Text("Dr. ${item.doctorSurname!}", style: const TextStyle(fontSize: 16, color: Colors.white),)
                                  ],
                                ),
                                item.state == false ? Image.asset("assets/img/props/play.png", height: 30,)
                                    : Image.asset("assets/img/props/pause.png", height: 30,),
                              ],
                            ),
                          ),
                        );
                      }
                  ),
                ),
              ],
            ),
            hasData == false ?
            Container(
              height: AppBar().preferredSize.height + 45,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: HexColor("144C55"),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 4,
                    blurRadius: 7,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {},
                      child: const Text("¡Termina de completar tu perfil!", style: TextStyle(color: Colors.white, fontSize: 20,),),
                    ),
                  )
              ),
            )
                : const SizedBox.shrink(),
          ],
        )
    );
  }

  initUserData() async{
    //Search for patient data
    localUser = await getLocalUser();
    var response = await getPatient(localUser.mail!);
    patient = response.elementAt(0);
    if(patient.name == null) {
      hasData = false;
    }
    else{
      hasData = true;
    }
    //Get Treatment Data
    treatments = await getTreatments(patient.userid);
    setState(() {});
  }

  showTreatment(TreatmentToPatient treatment){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TherapyInterface(patient: patient, treatment: treatment,),
      ),
    );
  }

  showProfile(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileInterface(patient: patient),
      ),
    );
  }
}


