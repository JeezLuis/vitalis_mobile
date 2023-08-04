import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:vitalis_mobile/Model/question.dart';

import '../network.dart';
import '../utils.dart';

final TextEditingController dayController = TextEditingController();
final TextEditingController monthController = TextEditingController();
final TextEditingController yearController = TextEditingController();


class DateQuestionDialog extends StatefulWidget {
  final Question question;

  const DateQuestionDialog({Key? key, required this.question}) : super(key: key);

  @override
  _DateQuestionDialogState createState() => _DateQuestionDialogState(question);
}

class _DateQuestionDialogState extends State<DateQuestionDialog> {
  final Question question;

  _DateQuestionDialogState(this.question);

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
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: const TextStyle(fontSize: 40),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              controller: dayController,
                              decoration: InputDecoration(
                                  counterText: "",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: AppLocalizations.of(context)!.answer_hint_day
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 10)),
                          Expanded(
                            child: TextField(
                              style: const TextStyle(fontSize: 40),
                              textAlign: TextAlign.center,
                              maxLength: 2,
                              keyboardType: TextInputType.number,
                              controller: monthController,
                              decoration: InputDecoration(
                                  counterText: "",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: AppLocalizations.of(context)!.answer_hint_month
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 10)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.36,
                            child: TextField(
                              style: const TextStyle(fontSize: 40),
                              textAlign: TextAlign.center,
                              maxLength: 4,
                              keyboardType: TextInputType.number,
                              controller: yearController,
                              decoration: InputDecoration(
                                  counterText: "",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: AppLocalizations.of(context)!.answer_hint_year
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 60)),
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
                          dayController.text = '';
                          monthController.text = '';
                          yearController.text = '';

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

  sendResponse() async {
    var dateString = "${dayController.text}.${monthController.text}.${yearController.text}";
    if(isDate(dateString)){
      var result = await respondQuestion(question, dateString);
      if(result == 0){
        Navigator.pop(context);
      }
      else{
        alertError(AppLocalizations.of(context)!.err_system_failure(result.toString()), context);
      }
    }
    else{
      alertError(AppLocalizations.of(context)!.err_wrong_date_format, context);
    }


  }

  bool isDate(String str) {
    try {
      DateFormat format = DateFormat("dd.MM.yyyy");
      format.parseStrict(str);
      return true;
    } catch (e) {
      return false;
    }
  }
}
