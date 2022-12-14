import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social/shared/styles/colors/colors.dart';
ThemeData lightTheme = ThemeData(
  primarySwatch:defaultColor,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  floatingActionButtonTheme:FloatingActionButtonThemeData(
    backgroundColor:defaultColor,
  ),
  bottomNavigationBarTheme:BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor:defaultColor,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
        color: Colors.black,
      ),
      subtitle1: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14.0,
        color: Colors.black,
        height: 1.3,
      ),
  ),
  scaffoldBackgroundColor: Colors.white,
);
ThemeData darkTheme =  ThemeData(
  primarySwatch:defaultColor,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  floatingActionButtonTheme:FloatingActionButtonThemeData(
    backgroundColor:defaultColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor:defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: HexColor('333739'),
  ),
  textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
        color: Colors.white,
      ),
    subtitle1: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14.0,
      color: Colors.white,
      height: 1.3,
    ),
  ),
  scaffoldBackgroundColor: HexColor('333739'),
);