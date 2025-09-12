import 'package:flutter/material.dart';

import 'UI/screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
          )
        ),
        colorSchemeSeed: Colors.green,//tap korle green effect dekhabe
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
              borderSide: BorderSide.none
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide.none
          ),
        ),

        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
              fixedSize:Size.fromWidth(double.maxFinite),
              padding: EdgeInsets.symmetric(vertical: 12),
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )
          ),
        )
      ),
      home: SplashScreen(),
    );
  }
}
