import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/constants/colors.dart';
import 'package:tez_projesi_android/pages/create_ai_recipe_page.dart';

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
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: buildAIComponent(
                        "assets/images/ai1.png",
                        "Bölgeye Göre",
                        "Sevdiğiniz mutfakları seçin ve yapay zeka sizin için tarif önersin!",
                        "location")),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: buildAIComponent(
                        "assets/images/ai2.png",
                        "Malzemeye Göre",
                        "Elinizde kalan malzemeleri söyleyin, bu malzemeler ile tarif önersin!",
                        "food")),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: buildAIComponent(
                        "assets/images/ai3.png",
                        "Öğüne Göre",
                        "Hangi öğün için yemek yapacağınızı seçin, gerisini yapay zekaya bırakın!",
                        "meal")),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: buildAIComponent(
                        "assets/images/ai4.png",
                        "Filtreye Göre",
                        "Birden çok filtre ile daha özelleştirilmiş tarfiler oluşturun!",
                        "multifilter")),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Widget buildAIComponent(
      String asset, String title, String desc, String type) {
    return InkWell(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateAiRecipePage(
                      type: type,
                    )))
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xfff5f5f5),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: TW3Colors.gray.shade300,
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(
              asset,
              width: 84,
              height: 84,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 14, color: TW3Colors.gray.shade700),
            ),
            Text(
              desc,
              style: TextStyle(
                fontSize: 10,
                color: TW3Colors.gray.shade400,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
