import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/components/button_component.dart';
import 'package:tez_projesi_android/components/input_component.dart';
import 'package:tez_projesi_android/components/recipe_item.dart';
import 'package:tez_projesi_android/constants/colors.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
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
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: TW3Colors.gray.shade200,
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: const TextStyle(fontSize: 10),
                            decoration: InputDecoration(
                                border: InputBorder.none, // Kenarlık yok
                                hintText: 'Tarif ara...',
                                hintStyle:
                                    TextStyle(color: TW3Colors.gray.shade400),
                                contentPadding: EdgeInsets.zero,
                                isDense: true),
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/icons/search.svg',
                          color: TW3Colors.gray.shade400,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tariflerim",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () => {
                    // ekle
                  },
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: CustomColors.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        "+",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: RecipeItem(
                      image: "assets/images/food3.png",
                      title: "Tarif Başlığı",
                      desc:
                          "Lorem ipsum dolor sit amet consectetur. Fermentum"),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: RecipeItem(
                      image: "assets/images/food2.png",
                      title: "Tarif Başlığı",
                      desc:
                          "Lorem ipsum dolor sit amet consectetur. Fermentum"),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: RecipeItem(
                      image: "assets/images/food3.png",
                      title: "Tarif Başlığı",
                      desc:
                          "Lorem ipsum dolor sit amet consectetur. Fermentum"),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: RecipeItem(
                      image: "assets/images/food2.png",
                      title: "Tarif Başlığı",
                      desc:
                          "Lorem ipsum dolor sit amet consectetur. Fermentum"),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
