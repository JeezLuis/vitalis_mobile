import 'package:flutter/material.dart';
import 'package:vitalis_mobile/Model/patient.dart';
import 'package:vitalis_mobile/Model/treatment_to_patient.dart';
import 'package:vitalis_mobile/utils.dart';



class TherapyInterface extends StatefulWidget {
  final Patient patient;
  final TreatmentToPatient treatment;

  const TherapyInterface({super.key, required this.patient, required this.treatment});

  @override
  State<StatefulWidget> createState() => _TherapyInterfaceState(patient, treatment);
}

class _TherapyInterfaceState extends State<TherapyInterface> {
  final Patient patient;
  final TreatmentToPatient treatment;

  _TherapyInterfaceState(this.patient, this.treatment);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: HexColor("3BB2C4"),
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
              child: Container(
                height: 80,
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(10,0,10,0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset("assets/img/props/back.png", height: 36,),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 5)),
                          SizedBox(
                            height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(treatment.title!, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24, color: Colors.white),),
                                Text(treatment.doctorTitle!, style: const TextStyle(fontSize: 16, color: Colors.white))
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                )
              )
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          const Text("Preguntas pendientes:", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),),
          const Padding(padding: EdgeInsets.only(top: 30)),

        ],
      ),
    );
  }
}


