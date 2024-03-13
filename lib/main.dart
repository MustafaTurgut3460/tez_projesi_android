import 'package:flutter/material.dart';
import 'package:tez_projesi_android/services/general/http_service.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final httpService = HttpService();
  String text = "Yükleniyor...";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    httpService.get("https://jsonplaceholder.typicode.com/todos/1").then((value) => {
      setState(() {
        text = value.body.toString();
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
