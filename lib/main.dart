import 'package:flutter/material.dart';
//import 'game.dart';
import 'start_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const StartScreen(),
      theme: ThemeData.light().copyWith(
        colorScheme: const ColorScheme.light(
          primary: Colors.blue, // Ana renk
          secondary: Colors.blueAccent, // Vurgu rengi
        ),
        scaffoldBackgroundColor: Colors.grey[200], // Arka plan rengi
        appBarTheme: AppBarTheme(
          color: Colors.blue[900], // App bar rengi
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blue, // Yükseltilmiþ düðme metin rengi
            textStyle: const TextStyle(
              fontSize: 18, // Yükseltilmiþ düðme metin boyutu
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  30), // Yükseltilmiþ düðme kenar yuvarlatma
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 30, vertical: 15), // Yükseltilmiþ düðme dolgusu
          ),
        ),
      ),
    );
  }
}
