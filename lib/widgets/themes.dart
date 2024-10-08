import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      primarySwatch: Colors.deepPurple,
      fontFamily: GoogleFonts.poppins().fontFamily,
      cardColor: Colors.white,
      canvasColor: creamColor,
      hintColor: darkBluishColor,
      // buttonColor: darkBluishColor,

      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black), toolbarTextStyle: Theme.of(context).textTheme.bodyMedium, titleTextStyle: Theme.of(context).textTheme.titleLarge,
      ));

  static ThemeData darkTheme(BuildContext context) => ThemeData(
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.poppins().fontFamily,
      cardColor: Colors.black,
      canvasColor: darkCreamColor,
      // buttonColor: lightBluishColor,
      hintColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: Colors.black,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black), toolbarTextStyle: Theme.of(context).textTheme.copyWith(
          titleLarge:
          context.textTheme.titleLarge?.copyWith(color: Colors.white),
        ).bodyMedium, titleTextStyle: Theme.of(context).textTheme.copyWith(
          titleLarge:
          context.textTheme.titleLarge?.copyWith(color: Colors.white),
        ).titleLarge,
      ));

  //Colors
  static Color creamColor = Color(0xfff5f5f5);
  static Color darkCreamColor = Vx.gray900;
  static Color darkBluishColor = Color(0xff403b48);
  static Color lightBluishColor = Vx.indigo500;
}