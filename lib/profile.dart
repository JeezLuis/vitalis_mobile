import 'package:flutter/material.dart';
import 'package:vitalis_mobile/Model/patient.dart';
import 'package:vitalis_mobile/settings.dart';
import 'package:vitalis_mobile/utils.dart';
import 'package:intl/intl.dart';


final TextEditingController emailController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController surnameController = TextEditingController();
final TextEditingController genderController = TextEditingController();
final TextEditingController birthdayController = TextEditingController();

class ProfileInterface extends StatefulWidget {
  final Patient patient;

  const ProfileInterface({super.key, required this.patient});

  @override
  State<StatefulWidget> createState() => _ProfileInterfaceState(patient);
}

class _ProfileInterfaceState extends State<ProfileInterface> {
  final Patient patient;
  bool viewMode = true;

  _ProfileInterfaceState(this.patient);


  @override
  void initState() {
    var dt = DateTime.fromMillisecondsSinceEpoch(patient.birthdate!);
    var date = DateFormat('MM/dd/yyyy').format(dt);

    emailController.text = patient.mail;
    nameController.text = patient.name!;
    surnameController.text = patient.surnames!;
    genderController.text = patient.gender!;
    birthdayController.text = date;

    super.initState();
  }

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
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Correo", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                const Padding(padding: EdgeInsets.only(top: 7)),
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
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Nombre", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                const Padding(padding: EdgeInsets.only(top: 7)),
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
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Apellidos", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                const Padding(padding: EdgeInsets.only(top: 7)),
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
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Genero", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                const Padding(padding: EdgeInsets.only(top: 7)),
                TextField(
                    onTap: () {
                      setGender();
                    },
                    controller: genderController,
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
                        hintText: 'Genero'
                    )
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Nacimiento", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                const Padding(padding: EdgeInsets.only(top: 7)),
                TextField(
                    onTap: () {
                      setBirthday();
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

  setBirthday(){
    //TODO: Llamar a la pregunta que pide fecha
  }

  setGender(){
    //TODO: Llamar a la pregunta que pregunta el genero
  }

  saveData(BuildContext context) async {
    if(viewMode == false){
      //TODO: Actualitzar les dades
    }

    viewMode = !viewMode;
    setState(() {});
  }
}


