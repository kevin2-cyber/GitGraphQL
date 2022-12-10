import 'package:ecommerce_app/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {

  // a better error screen
  ErrorWidget.builder = (FlutterErrorDetails details) => Material(
    color: Colors.greenAccent.shade100,
    child: Center(
      child: Text(
        details.exceptionAsString(),
        style: GoogleFonts.lexendDeca(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();

  // device orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const App());
}