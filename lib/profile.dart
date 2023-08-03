import 'package:flutter/material.dart';
import 'package:vitalis_mobile/Model/patient.dart';
import 'package:vitalis_mobile/settings.dart';
import 'package:vitalis_mobile/utils.dart';
import 'package:intl/intl.dart';
import 'constants.dart' as Constants;
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
  State<StatefulWidget> createState() => _ProfileInterfaceState(patient, viewMode);
}

class _ProfileInterfaceState extends State<ProfileInterface> {
  final Patient patient;
  bool viewMode;
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
                const Text("ID PACIENTE:", style: TextStyle(fontSize: 15, color: Colors.white),),
                Text(patient.userkey, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
            child: Column(
              children: [
                //Mail
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Correo", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
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
                        hintText: 'Correo'
                    )
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                //Name
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Nombre", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
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
                        hintText: 'Nombre'
                    )
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                //Surnames
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Apellidos", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
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
                        hintText: 'Apellidos'
                    )
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                //Gender
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Genero", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
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
                    hintText: dropdownValueGender.isEmpty ? "Gender" : dropdownValueGender,
                    hintStyle: dropdownValueGender.isEmpty ? const TextStyle() : const TextStyle(color: Colors.black),
                  ),
                  items: Constants.genders.map<DropdownMenuItem<String>>((String gender) {
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
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Nacimiento", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
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
                        hintText: 'Nacimiento'
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


