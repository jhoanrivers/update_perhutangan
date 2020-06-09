


import 'package:flutter/material.dart';

class BaseStyle {

  //Color
  static Color primaryBlack = Color(0xff1f1f1f);
  static Color lightBlue = Color(0xffb2ebf2);
  static Color darkBlue = Color(0xff00a8cc);
  static Color disableBtnColor = Color(0xffaeaeae);
  static Color hintBgTextfieldColor = Color(0xffefefef);
  static Color hintTextColor = Color(0xffaeaeae);
  static Color orangeTextColor = Color(0xfff78259);
  static Color errorTextColor = Color(0xffe43f5a);
  static Color orangeBtnColor = Color(0xfff78259);


  static String fontFamily = "Montserrat";
  static FontWeight bold = FontWeight.w800;

  static TextStyle ts18WhiteBold = TextStyle(
    fontFamily: fontFamily,
    color: Colors.white,
    fontSize: 18,
    fontWeight: bold
  );

  static TextStyle ts14Red = TextStyle(
      fontFamily: fontFamily,
      color: Colors.red,
      fontSize: 14,
      fontWeight: bold
  );



  static TextStyle ts14White = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    color: Colors.white
  );

  static TextStyle ts12PrimaryLabel = TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      color: Colors.black26,
      fontWeight: bold
  );

  static TextStyle ts12BlueBold = TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      color: Colors.blue,
      fontWeight: bold
  );


  static TextStyle ts14PrimaryName = TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      color: Colors.black
  );

  static TextStyle ts14PrimaryBold = TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      color: Colors.black,
      fontWeight: bold
  );

  static TextStyle tsAppBar = TextStyle(
      color: Colors.white
  );


  static TextStyle ts16RedBold = TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      color: Colors.red,
      fontWeight: bold
  );

  static TextStyle ts16GreenBold = TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      color: Colors.green,
      fontWeight: bold
  );





}