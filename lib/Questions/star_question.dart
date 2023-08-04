// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vitalis_mobile/Model/question.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../network.dart';
import '../utils.dart';

class StarQuestionDialog extends StatefulWidget {
  final Question question;

  const StarQuestionDialog({Key? key, required this.question}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _StarQuestionDialogState createState() => _StarQuestionDialogState(question);
}

class _StarQuestionDialogState extends State<StarQuestionDialog> {
  final Question question;
  String answer = '';

  _StarQuestionDialogState(this.question);

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
                    child: Center(
                      child: RatingBar(
                        itemSize: 60,
                        glow: false,
                        initialRating: 2.5,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                        /*itemBuilder: (context, _) => const Icon(
                          Icons.star_border,
                          color: Colors.amber,
                        ),*/
                        ratingWidget: RatingWidget(
                          full: const Icon(Icons.star, color: Colors.amber,),
                          half: const Icon(Icons.star_half, color: Colors.amber,),
                          empty: const Icon(Icons.star_border, color: Colors.amber,),
                        ),
                        onRatingUpdate: (rating) {
                          answer = rating.toString();
                        },
                      ),
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

  sendResponse() async {
    if(answer.isNotEmpty) {
      var result = await respondQuestion(question, answer);
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
