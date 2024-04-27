import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/constants/colors.dart';

class AIPage extends StatefulWidget {
  const AIPage({super.key});

  @override
  State<AIPage> createState() => _AIPageState();
}

class _AIPageState extends State<AIPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            const Text(
              "Yapay Zeka İle Tarif Oluşturun",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            Text(
              "Aşağıdaki seçenekler ile yapay zeka aracınızı kullanarak yep yeni tarifler oluşturun!",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: TW3Colors.gray.shade400),
            ),
          ],
        ),
      ),
    ));
  }

  Widget buildAiBox(String asset, String title, String desc){
    return Container();
  }
}
