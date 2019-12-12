import 'package:flutter/material.dart';
import 'package:lista_de_contatos/ui/home_page.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      accentColor: Colors.blueAccent,
      backgroundColor: Colors.white,
      primaryColor: Colors.blue.shade600,
      hintColor: Colors.lightBlue,
      cardTheme: CardTheme(
        color: Colors.white,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.blue
      )
    ),
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}
