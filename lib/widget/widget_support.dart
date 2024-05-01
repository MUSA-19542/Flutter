import 'dart:ui';

import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle boldTextFieldStyle() {
    return TextStyle(
        color: Colors.black,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle boldTextFieldStyleCustom(Color c) {
    return TextStyle(
        color: c,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle boldTextFieldStyleCustomC(Color c,double size) {
    return TextStyle(
        color: c,
        fontSize: size,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }


  static TextStyle HeadlineTextFieldStyle() {
    return TextStyle(
        color: Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }
  static TextStyle HeadlineTextFieldStyleCustom(double size, Color c) {
    return TextStyle(
        color: c,
        fontSize: size,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }
  static TextStyle LightTextFieldStyle() {
    return TextStyle(
        color: Colors.black38,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');

  }
  static TextStyle LightlessTextFieldStyle() {
    return TextStyle(
        color: Colors.black38,
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');

  }

  static TextStyle LightlessTextFieldStyleCustom(Color c,double s) {
    return TextStyle(
        color: c,
        fontSize: s,
        fontFamily: 'Poppins');

  }

  static TextStyle SemiboldTextFieldStyle() {
    return TextStyle(
        color: Colors.black,
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins');
  }

  static TextStyle SemiboldTextFieldStyleCustom(Color c,double size) {
    return TextStyle(
        color: c,
        fontSize: size,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins');
  }

  static TextStyle PriceTextFieldStyle() {
    return TextStyle(
      color: Colors.red,
      fontSize: 15.0,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    );
  }
  static TextStyle PriceTextFieldStyleCustom(double size) {
    return TextStyle(
      color: Colors.red,
      fontSize: size,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    );
  }
}
