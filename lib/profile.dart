import 'package:flutter/material.dart';
import 'package:vitalis_mobile/Model/patient.dart';
import 'package:vitalis_mobile/settings.dart';
import 'package:vitalis_mobile/utils.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'constants.dart' as constants;
import 'network.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController surnameController = TextEditingController();
final TextEditingController birthdayController = TextEditingController();

class ProfileInterface extends StatefulWidget {
  final Patient patient;
  final bool viewMode;

  const ProfileInterface({super.key, required this.patient, required this.viewMode});

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _ProfileInterfaceState(patient, viewMode);
}

class _ProfileInterfaceState extends State<ProfileInterface> {
  ///The [patient] the profile is of
  final Patient patient;
  ///Mode that determines if user can edit the information
  bool viewMode;
  ///Selected gender value
  String dropdownValueGender = '';


  _ProfileInterfaceState(this.patient, this.viewMode);


  @override
  void initState() {
    //Initialize data
    nameController.text = '';
    surnameController.text = '';
    birthdayController.text = '';
    dropdownValueGender = '';

    emailController.text = patient.mail;
    if(patient.name != null) nameController.text = patient.name!;
    if(patient.surnames != null) surnameController.text = patient.surnames!;
    if(patient.gender != null) dropdownValueGender = patient.gender!;
    if(patient.birthdate != null){
      var dt = DateTime.fromMillisecondsSinceEpoch(patient.birthdate!);
      var date = DateFormat('dd/MM/yyyy').format(dt);
      birthdayController.text = date;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          //App NavBar
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
                            child: Text( AppLocalizations.of(context)!.profile_title,
                                style: const TextStyle(
                                    fontFamily: 'GLORIOUS',
                                    fontSize: 40,
                                    color: Colors.white,
                                    shadows: <Shadow>[Shadow(color: Colors.black38, offset: Offset(3.0, 3.0), blurRadius: 4.0)]
                                )
                            ),
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsInterface(),
                            ),
                          );
                        },
                        child: Image.asset("assets/img/props/settings.png", height: 36,),
                      ),
                    )
                  ],
                ),
              )
          ),
          //Patient unique KEY
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
                Text(AppLocalizations.of(context)!.patient_id, style: const TextStyle(fontSize: 15, color: Colors.white),),
                Text(patient.userkey, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
            child: Column(
              children: [
                //Mail
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(AppLocalizations.of(context)!.mail, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                const Padding(padding: EdgeInsets.only(top: 7)),
                //Mail Text Field
                TextField(
                    controller: emailController,
                    enableSuggestions: false,
                    autocorrect: false,
                    readOnly: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: HexColor("D9D9D9"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintText: AppLocalizations.of(context)!.mail
                    )
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                //Name
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(AppLocalizations.of(context)!.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                const Padding(padding: EdgeInsets.only(top: 7)),
                //Name Text Field
                TextField(
                    controller: nameController,
                    enableSuggestions: false,
                    autocorrect: false,
                    readOnly: viewMode,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: viewMode == true ? HexColor("D9D9D9") : HexColor("95EBF9"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintText: AppLocalizations.of(context)!.name
                    )
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                //Surnames
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(AppLocalizations.of(context)!.surname, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                const Padding(padding: EdgeInsets.only(top: 7)),
                //Surnames Text Field
                TextField(
                    controller: surnameController,
                    enableSuggestions: false,
                    autocorrect: false,
                    readOnly: viewMode,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: viewMode == true ? HexColor("D9D9D9") : HexColor("95EBF9"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintText: AppLocalizations.of(context)!.surname
                    )
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                //Gender
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(AppLocalizations.of(context)!.gender, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                const Padding(padding: EdgeInsets.only(top: 7)),
                //Gender Text Field
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: viewMode == true ? HexColor("D9D9D9") : HexColor("95EBF9"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    hintText: dropdownValueGender.isEmpty ? AppLocalizations.of(context)!.gender : dropdownValueGender,
                    hintStyle: dropdownValueGender.isEmpty ? const TextStyle() : const TextStyle(color: Colors.black),
                  ),
                  items: constants.genders.map<DropdownMenuItem<String>>((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: viewMode == true ? null : (String? gender) {
                    patient.gender = gender;
                    setState(() {
                      dropdownValueGender = gender!;
                    });
                  },

                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                //Birthdate
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(AppLocalizations.of(context)!.birthdate, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                const Padding(padding: EdgeInsets.only(top: 7)),
                //Birthdate Text Field
                TextField(
                    onTap: () {
                      if(!viewMode) setBirthday();
                    },
                    controller: birthdayController,
                    enableSuggestions: false,
                    autocorrect: false,
                    readOnly: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: viewMode == true ? HexColor("D9D9D9") : HexColor("95EBF9"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintText: AppLocalizations.of(context)!.birthdate
                    )
                ),
                const Padding(padding: EdgeInsets.only(top: 25)),
                //Edit/Save Button
                GestureDetector(
                  onTap: () {
                    saveData(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor("246D78"),
                      borderRadius: const BorderRadius.all(Radius.circular(60)),
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
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: viewMode == true ? Image.asset("assets/img/props/edit.png",width: 45,)
                              : Image.asset("assets/img/props/save.png", width: 45,),
                          )
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///Sets [patient] birthday if desired
  setBirthday() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: patient.birthdate != null ?
          DateTime.fromMillisecondsSinceEpoch(patient.birthdate!) :
          DateTime.now(),
        lastDate: DateTime(3000),
        firstDate: DateTime(1900),
    );
    if(pickedDate != null) {
      patient.birthdate = pickedDate.millisecondsSinceEpoch;
      var dt = DateTime.fromMillisecondsSinceEpoch(patient.birthdate!);
      var date = DateFormat('dd/MM/yyyy').format(dt);
      birthdayController.text = date;
    }
  }

  ///Updates [patient] data to the database
  saveData(BuildContext context) async {
    if(viewMode == false){
      patient.name = nameController.text;
      patient.surnames = surnameController.text;
      await updatePatient(patient);
      viewMode = !viewMode;
    }
    else{
      viewMode = !viewMode;
    }
    setState(() {});
  }
}


