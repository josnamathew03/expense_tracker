import 'package:expense_tracker/expense.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 96, 59, 181)
); //k is for starting global variable. fromseed allow to select different colors from the base color.

var kDarkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 5, 99, 125),
    brightness: Brightness.dark,
); //for dark theme

void main(){
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      colorScheme: kDarkColorScheme,
      cardTheme:const CardTheme().copyWith(
        color: kDarkColorScheme.secondaryContainer,
        margin:const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          )
      ),
    ),
    theme: ThemeData().copyWith(
        //scaffoldBackgroundColor: Colors.blueGrey,
      //elevatedButtonTheme: ElevatedButtonThemeData(),
      colorScheme: kColorScheme ,//set up colors of many widgets, without maually setting a bunch of colors individually. using colorscheme we can define one colorscheme.
      appBarTheme:const AppBarTheme().copyWith(
        backgroundColor: kColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.primaryContainer,
      ),
      cardTheme:const CardTheme().copyWith(
        color: kColorScheme.secondaryContainer,
        margin:const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.primaryContainer,
        )
      ),
      textTheme: ThemeData().textTheme.copyWith(
        titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSecondaryContainer,
          fontSize: 16,
        ),
      ),
    ),//we can set the theme of our choice.ThemeData class has lot of parameters which can be used.copyWith can have primaryColor or selected colors like scaffoldBackground color or we cn set up entire theming of widgets like buttons etc.
    //themeMode: ThemeMode.system,//which one needs to be set. system to check the system and what is sected bu the user.this happens in default so we dont need to set it.

    home:const Expenses(),
  ),
  );
}