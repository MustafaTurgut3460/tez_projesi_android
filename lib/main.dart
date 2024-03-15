import 'package:flutter/material.dart';
import 'package:tez_projesi_android/pages/login_page.dart';
import 'package:tez_projesi_android/services/general/http_service.dart';

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
      home: const LoginPage(),
    );
  }
}
