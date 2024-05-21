import 'package:flutter/material.dart';


class SHelperFunction{
  static bool isDarkMode(BuildContext context){
    return Theme.of(context).brightness == Brightness.dark;
  }
}