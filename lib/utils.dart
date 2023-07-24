import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;

///Generates HexColor from hex string
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

///Alert message for errors
void alertError(String message, BuildContext context){
  QuickAlert.show(
    context: context,
    type: QuickAlertType.error,
    title: 'Oops...',
    text: message,
    confirmBtnColor: HexColor("246D78"),
    backgroundColor: HexColor("FFFFFF"),
  );
}

///Alert message for information
void alertInfo(String message, BuildContext context){
  QuickAlert.show(
    context: context,
    type: QuickAlertType.success,
    text: message,
    confirmBtnColor: HexColor("246D78"),
    backgroundColor: HexColor("FFFFFF"),
  );
}

///Generate MD5 hash
generateMd5(String data) {
  var content = new Utf8Encoder().convert(data);
  var md5 = crypto.md5;
  var digest = md5.convert(content);
  return hex.encode(digest.bytes);
}

