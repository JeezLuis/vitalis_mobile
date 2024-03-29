// ignore_for_file: library_private_types_in_public_api, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vitalis_mobile/Model/question.dart';

import '../network.dart';
import '../utils.dart';

class BooleanQuestionDialog extends StatefulWidget {
  final Question question;

  const BooleanQuestionDialog({Key? key, required this.question}) : super(key: key);

  @override
  _BooleanQuestionDialogState createState() => _BooleanQuestionDialogState(question);
}

class _BooleanQuestionDialogState extends State<BooleanQuestionDialog> {
  ///Question the response is for
  final Question question;
  ///Current answer selected
  String answer = '';

  _BooleanQuestionDialogState(this.question);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: HexColor("246D78"),
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width,
            top: MediaQuery.of(context).size.height*0.25,
            child: const Image(image: AssetImage("assets/img/background/logobg.png")),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/img/background/logoxs.png", height: 48,),
                  Text(question.question!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                            onTap: (){
                              answer = 'Yes';
                              setState(() {});
                            },
                            child: Icon(Icons.check_circle_outline,  size: 120,color: answer == 'Yes' ? Colors.green : Colors.black45,)),
                        GestureDetector(
                            onTap: (){
                              answer = 'No';
                              setState(() {});
                            },
                            child: Icon(Icons.cancel_outlined,  size: 120,color: answer == 'No' ? Colors.red : Colors.black45,)),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor("4ADFF7"),
                          foregroundColor: Colors.black,
                          textStyle: const TextStyle(fontSize: 18),
                          fixedSize: const Size(130, 47),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          sendResponse();
                        },
                        child: Text(AppLocalizations.of(context)!.answer),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 18),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(AppLocalizations.of(context)!.answer_later),
                      ),
                    ],
                  )
                ],
              ),
            ),),
        ],
      ),
    );
  }

  ///Post response to database assigning it to the given [question]
  sendResponse() async {
    if(answer.isNotEmpty) {
      var result = await respondQuestion(question, answer);
      if (result == 0) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
      else {
        // ignore: use_build_context_synchronously
        alertError(AppLocalizations.of(context)!.err_system_failure(result.toString()), context);
      }
    }
    else{
      alertError(AppLocalizations.of(context)!.err_missing_fields, context);
    }
  }
}
