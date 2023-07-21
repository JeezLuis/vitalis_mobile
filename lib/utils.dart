import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

//Generates HexColor from hex string
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

void alertError(String message, BuildContext context){
  QuickAlert.show(
    context: context,
    type: QuickAlertType.error,
    title: 'Oops...',
    text: message,
    confirmBtnColor: HexColor("868C9E"),
    backgroundColor: HexColor("FBF1E1"),
  );
}

void alertInfo(String message, BuildContext context){
  QuickAlert.show(
    context: context,
    type: QuickAlertType.success,
    text: message,
    confirmBtnColor: HexColor("868C9E"),
    backgroundColor: HexColor("FBF1E1"),
  );
}

