import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTheme{
  static final darkTheme = ThemeData(

    scaffoldBackgroundColor: Colors.grey.shade900,
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      subtitle1: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        height: 1.3,
      ),
    ),
    colorScheme: ColorScheme.dark(primary: Colors.blue),
    primaryColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.blue,opacity: 0.8),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,

      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      elevation: 20,
      backgroundColor: Colors.black12,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade900,
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.grey.shade900,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    fontFamily: 'jannah',

  );

  static final lightTheme  = ThemeData(

    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      subtitle1: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        height: 1.3,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(primary: Colors.blue),
    primaryColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.blue,opacity: 0.8),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey  ,
      elevation: 20,
      backgroundColor:Colors.white,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,

      ),

    ),
    fontFamily: 'jannah',
  );
}

