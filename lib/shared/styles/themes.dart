

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
  primaryColor: defaultColor,

  scaffoldBackgroundColor: Colors.black12,
  appBarTheme: AppBarTheme(
    //   backwardsCompatibility: falce,
    titleSpacing: 20,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light
    ),
    backgroundColor: Colors.black12,
    elevation: 0.0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    elevation: 20,
    backgroundColor: Colors.black12,
  ),
  textTheme: TextTheme(
    bodyLarge:
    TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600
    ),

  ),
  fontFamily: 'Janaah',
);

ThemeData lightTheme = ThemeData(

  primaryColor: defaultColor,
  //primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    //   backwardsCompatibility: falce,
    //   systemOverlayStyle: systemUiOverlayStyle(
    //     stateusBarColor:Colors.white                خاص بل استيتس بار
    //     stateusBarIconbrBrightness:Brightness.dark
    //   ),
    titleSpacing: 20,
    backgroundColor: Colors.white,
    elevation: 0.0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: defaultColor,
    type: BottomNavigationBarType.fixed,
    elevation: 20,
    backgroundColor: Colors.white,


  ),
  textTheme: TextTheme(
    bodyLarge:
    TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
    ),
  ),
  fontFamily: 'Janaah'
);