import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/constants/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6)),
                        child: Image.asset(
                          "assets/images/efsanevi.png",
                          width: 36,
                          height: 36,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Merhaba "),
                              Text(
                                "Mustafa,",
                                style: TextStyle(color: CustomColors.primary),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Bugün hangi yemeği yapmak istersin?",
                            style: TextStyle(
                                color: TW3Colors.gray.shade400,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: TW3Colors.gray.shade200,
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/bell.svg',
                      color: TW3Colors.gray.shade400,
                    ),
                  )
                ],
              ),
              const SizedBox(
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
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/food4.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Haftanın Yemeği",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const Opacity(
                      opacity: 0.7,
                      child: Text(
                        "Lorem ipsum dolor sit amet consectetur. Risus amet fermentum quis felis.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/profile.svg',
                          color: TW3Colors.gray.shade400,
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Opacity(
                          opacity: 0.7,
                          child: Text(
                            "Mustafa Turgut",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        "En Çok Beğenilen Tarifler",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Image.asset(
                        'assets/icons/fire.png',
                      ),
                    ],
                  ),
                  Text(
                    "Tümünü Gör",
                    style:
                        TextStyle(color: TW3Colors.gray.shade500, fontSize: 12),
                  )
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    buildFoodComponent("assets/images/food2.png", "Yemek 1"),
                    const SizedBox(
                      width: 12,
                    ),
                    buildFoodComponent("assets/images/food2.png", "Yemek 1"),
                    const SizedBox(
                      width: 12,
                    ),
                    buildFoodComponent("assets/images/food2.png", "Yemek 1"),
                    const SizedBox(
                      width: 12,
                    ),
                    buildFoodComponent("assets/images/food2.png", "Yemek 1"),
                    const SizedBox(
                      width: 12,
                    ),
                    buildFoodComponent("assets/images/food2.png", "Yemek 1"),
                    const SizedBox(
                      width: 12,
                    ),
                    buildFoodComponent("assets/images/food2.png", "Yemek 1"),
                    const SizedBox(
                      width: 12,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Text(
                        "Yeni Tarifler Keşfedin",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                    ],
                  ),
                  Text(
                    "Tümünü Gör",
                    style:
                        TextStyle(color: TW3Colors.gray.shade500, fontSize: 12),
                  )
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    buildFoodComponent("assets/images/food2.png", "Yemek 1"),
                    const SizedBox(
                      width: 12,
                    ),
                    buildFoodComponent("assets/images/food2.png", "Yemek 1"),
                    const SizedBox(
                      width: 12,
                    ),
                    buildFoodComponent("assets/images/food2.png", "Yemek 1"),
                    const SizedBox(
                      width: 12,
                    ),
                    buildFoodComponent("assets/images/food2.png", "Yemek 1"),
                    const SizedBox(
                      width: 12,
                    ),
                    buildFoodComponent("assets/images/food2.png", "Yemek 1"),
                    const SizedBox(
                      width: 12,
                    ),
                    buildFoodComponent("assets/images/food2.png", "Yemek 1"),
                    const SizedBox(
                      width: 12,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Text(
                        "Kategoriler",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                    ],
                  ),
                  Text(
                    "Tümünü Gör",
                    style:
                        TextStyle(color: TW3Colors.gray.shade500, fontSize: 12),
                  )
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    buildCategoryComponent(
                        "assets/icons/breakfast.png", "Kahvaltı"),
                    const SizedBox(
                      width: 12,
                    ),
                    buildCategoryComponent(
                        "assets/icons/breakfast.png", "Kahvaltı"),
                    const SizedBox(
                      width: 12,
                    ),
                    buildCategoryComponent(
                        "assets/icons/breakfast.png", "Kahvaltı"),
                    const SizedBox(
                      width: 12,
                    ),
                    buildCategoryComponent(
                        "assets/icons/breakfast.png", "Kahvaltı"),
                    const SizedBox(
                      width: 12,
                    ),
                    buildCategoryComponent(
                        "assets/icons/breakfast.png", "Kahvaltı"),
                    const SizedBox(
                      width: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFoodComponent(String asset, String title) {
    return Column(
      children: [
        Image.asset(
          asset,
          width: 64,
          height: 64,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 12, color: TW3Colors.gray.shade500),
        )
      ],
    );
  }

  Widget buildCategoryComponent(String asset, String title) {
    return Container(
      width: 72,
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Image.asset(
            asset,
            width: 36,
            height: 36,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: TW3Colors.gray.shade500),
          )
        ],
      ),
    );
  }
}
