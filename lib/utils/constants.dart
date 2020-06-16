import 'package:flutter/material.dart';

const Color kOrange = Color(0xFFFF5500);
const Color kLightGray = Color(0xFF8E8E93);
const Color kDarkGray = Color(0xFF242424);

ThemeData kDarkTheme = ThemeData(
  // Define the default brightness and colors.
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  primaryColor: Color(0xFF242424),
  accentColor: Color(0xFFFF5500),
  cardColor: Color(0xFF242424),

  // Define the default font family.
  fontFamily: 'Roboto',

  // Define the default TextTheme. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  // textTheme: TextTheme(
  //   headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
  //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  // ),
);

const kH1 = TextStyle(fontFamily: 'Teko', fontSize: 48);
