import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vitalis_mobile/Model/patient.dart';
import 'package:vitalis_mobile/Model/treatment_to_patient.dart';
import 'package:vitalis_mobile/network.dart';
import 'package:vitalis_mobile/utils.dart';

import 'Model/question.dart';
import 'Model/response.dart';
import 'Questions/text_question.dart';



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
  List<Question> questions = <Question>[];

  _TherapyInterfaceState(this.patient, this.treatment);


  @override
  void initState() {
    collectQuestions();
  }

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
          Expanded(
              child: RefreshIndicator(
                onRefresh: () => collectQuestions(),
                child: ListView.builder(
                    itemCount: questions.length,
                    itemBuilder: (BuildContext context, int index){
                      Question item = questions[index];
                      return GestureDetector(
                        onTap: () async {
                          if(item.answered == false){
                            await questionType(item);
                            collectQuestions();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10,15,10,15),
                          margin: const EdgeInsets.fromLTRB(15,0,15,20),
                          decoration: BoxDecoration(
                            color: item.answered == false ? HexColor("4ADFF7") : HexColor("8E8E8E"),
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
                              Text(item.question!, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.white),),
                              Text(item.time!, style: const TextStyle(fontSize: 15 ,color: Colors.white),),
                            ],
                          ),
                        ),
                      );
                    }
                ),
              )
          ),
        ],
      ),
    );
  }

  collectQuestions() async {
    questions = <Question>[];
    var aux_questions = await getQuestions(treatment.objectid!);
    for(Question question in aux_questions){
      //Check if question has been answered
      List<Response> responses = await getTodayResponses(question.objectId!);
      if(responses.isNotEmpty) question.answered = true;

      //Check if it is time to answer already
      DateTime hour = DateFormat("hh:mm").parse(question.time!);
      DateTime now = DateTime(hour.year, hour.month, hour.day, DateTime.now().hour , DateTime.now().minute);
      if(hour.isBefore(now)){
        if(question.repetition == 'Siempre') {
          questions.add(question);
        }
        else{
          switch (DateTime.now().weekday){
            case DateTime.monday:
              if(question.repetition == 'Lunes') questions.add(question);
              break;
            case DateTime.tuesday:
              if(question.repetition == 'Martes') questions.add(question);
              break;
            case DateTime.wednesday:
              if(question.repetition == 'Miercoles') questions.add(question);
              break;
            case DateTime.thursday:
              if(question.repetition == 'Jueves') questions.add(question);
              break;
            case DateTime.friday:
              if(question.repetition == 'Viernes') questions.add(question);
              break;
            case DateTime.saturday:
              if(question.repetition == 'Sabado') questions.add(question);
              break;
            case DateTime.sunday:
              if(question.repetition == 'Domingo') questions.add(question);
              break;
          }
        }
      }
    }
    setState(() {});
  }

  questionType(Question question) async {
    switch (question.type) {
      case 1: //Text
        await showDialog(context: context,
            useSafeArea: false,
            builder: (BuildContext context){
              return TextQuestionDialog(
                question: question,
              );
            }
        );
        break;
      case 2: //Text XL
        break;
      case 3: //Date
        break;
      case 4: //Number
        break;
      case 5: //Bool
        break;
      case 6: //Star
        break;
      case 7: //Rating
        break;
    }
  }
}


