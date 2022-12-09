import 'package:ecommerce_app/app/ui/screens/intro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.lexendDecaTextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.lexendDecaTextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Intro()
    );
  }
}
