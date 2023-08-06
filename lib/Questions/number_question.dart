// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vitalis_mobile/Model/question.dart';

import '../network.dart';
import '../utils.dart';

final TextEditingController answerController = TextEditingController();

class NumberQuestionDialog extends StatefulWidget {
  final Question question;

  const NumberQuestionDialog({Key? key, required this.question}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state, library_private_types_in_public_api
  _NumberQuestionDialogState createState() => _NumberQuestionDialogState(question);
}

class _NumberQuestionDialogState extends State<NumberQuestionDialog> {
  ///Question the response is for
  final Question question;

  _NumberQuestionDialogState(this.question);

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
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50,right: 50),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: answerController,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 40),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              hintText: AppLocalizations.of(context)!.answer_hint_number
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20)),
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
                          answerController.text = '';
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
    if(answerController.text.isNotEmpty) {
      var result = await respondQuestion(question, answerController.text);
      if (result == 0) {
        Navigator.pop(context);
      }
      else {
        alertError(AppLocalizations.of(context)!.err_system_failure(result.toString()), context);
      }
    }
    else{
      alertError(AppLocalizations.of(context)!.err_missing_fields, context);
    }
  }
}
