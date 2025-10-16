import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';  // Import google_fonts
import 'package:my_portfolio/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        // Apply Montserrat font globally to the text theme
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,  // Apply Montserrat to the existing text theme
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
