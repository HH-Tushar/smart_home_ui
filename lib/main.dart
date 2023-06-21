import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_home_ui/ui/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modern Smart Home',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.openSans().fontFamily,
        textTheme: TextTheme(

          bodyMedium: TextStyle(
            // fontWeight: FontWeight.bold,
            fontSize: 20, color: Colors.grey.shade800,
            fontFamily: GoogleFonts.openSans().fontFamily,
          ),
          headlineLarge: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 26,
            fontFamily: GoogleFonts.openSans().fontFamily,
          ),


        ),

      ),
      home:  HomeScreen(),
    );
  }
}
