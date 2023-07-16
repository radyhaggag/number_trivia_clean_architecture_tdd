import 'package:flutter/material.dart';

import 'features/number_trivia/presentation/screens/number_trivia_screen.dart';

class NumberTriviaApp extends StatelessWidget {
  const NumberTriviaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Number trivia',
      color: Colors.blue,
      theme: _getTheme(),
      home: const NumberTriviaScreen(),
    );
  }
}

ThemeData _getTheme() => ThemeData(
      primaryColor: Colors.blue,
      appBarTheme: const AppBarTheme(
        color: Colors.blue,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      useMaterial3: true,
    );
