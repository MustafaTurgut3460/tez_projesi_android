import 'package:flutter/material.dart';
import 'package:tez_projesi_android/pages/email_confirm_page.dart';
import 'package:tez_projesi_android/pages/main_page.dart';
import 'package:tez_projesi_android/pages/register_page_1.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Poppins"
      ),
      home: const MainPage(),
    );
  }
}
