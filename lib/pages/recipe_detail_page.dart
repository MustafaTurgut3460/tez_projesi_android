import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/constants/colors.dart';
import 'package:tez_projesi_android/models/recipe.dart';

class RecipesDetailPage extends StatefulWidget {
  final Recipe recipe;
  const RecipesDetailPage({super.key, required this.recipe});

  @override
  State<RecipesDetailPage> createState() => _RecipesDetailPageState();
}

class _RecipesDetailPageState extends State<RecipesDetailPage> {
  var selectedTab = 1;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      widget.recipe.recipeSteps.sort(
        (a, b) => a.stepNumber.compareTo(b.stepNumber),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: SafeArea(
            child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                "https://blobcontainerapposite.blob.core.windows.net/mediafiles/mediafiles/079ae404-2049-4a7f-a64a-c1f468d950d0.png",
                width: MediaQuery.of(context).size.width,
                height: 220,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Yemek ismi buradadaır",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      decoration: BoxDecoration(color: TW3Colors.gray.shade300),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                  color: TW3Colors.gray.shade300,
                                  borderRadius: BorderRadius.circular(40)),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Mustafa Turgut",
                                ),
                                Text(
                                  "mustafa.turgut3460@gmail.com",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: TW3Colors.gray.shade500),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.bookmark_outline,
                              color: TW3Colors.gray.shade500,
                            ),
                            Text(
                              "24",
                              style: TextStyle(
                                fontSize: 12,
                                color: TW3Colors.gray.shade500,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: TW3Colors.gray.shade200,
                            borderRadius: BorderRadius.circular(100)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildTabs("Özet", 1),
                            buildTabs("Malzemeler", 2),
                            buildTabs("Yapılışı", 3),
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    getSelectedTab(),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Opacity(
              opacity: 0.6,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.arrow_back,
                  size: 24,
                  color: TW3Colors.gray.shade500,
                ),
              ),
            ),
          )
        ])),
      ),
    );
  }

  Widget buildTabs(String title, int index) {
    return (InkWell(
      onTap: () => {
        setState(() {
          selectedTab = index;
        })
      },
      child: Container(
        decoration: BoxDecoration(
          color: selectedTab == index
              ? CustomColors.primary
              : TW3Colors.gray.shade200,
          borderRadius: BorderRadius.circular(100),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
        child: Text(
          title,
          style: TextStyle(
              color: selectedTab == index
                  ? Colors.white
                  : TW3Colors.gray.shade600),
        ),
      ),
    ));
  }

  Widget getSelectedTab() {
    return selectedTab == 1
        ? Container(
            child: Column(
              children: [
                Text(
                  widget.recipe.description,
                  style: TextStyle(color: TW3Colors.gray.shade600),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildCards(
                        "Süre", "${widget.recipe.preparationTime} Dakika"),
                    buildCards("Kalori", "${widget.recipe.calories} Kalori"),
                    buildCards("Bölge", "Türkiye"),
                    buildCards("Seviye", "Orta Seviye"),
                  ],
                )
              ],
            ),
          )
        : selectedTab == 2
            ? Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Malzemeler (${widget.recipe.recipeIngredients.length})",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    for (int i = 0;
                        i < widget.recipe.recipeIngredients.length;
                        i++) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.recipe.recipeIngredients[i].name,
                            style: TextStyle(color: TW3Colors.gray.shade600),
                          ),
                          Text(
                            "${widget.recipe.recipeIngredients[i].quantity} ${widget.recipe.recipeIngredients[i].quantityType}",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  ],
                ),
              )
            : Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0;
                        i < widget.recipe.recipeSteps.length;
                        i++) ...[
                      buildSteps(
                          widget.recipe.recipeSteps[i].stepNumber.toString(),
                          widget.recipe.recipeSteps[i].description),
                      if (i != widget.recipe.recipeSteps.length - 1)
                        const SizedBox(height: 8),
                    ]
                  ],
                ),
              );
  }

  Widget buildCards(String title, String value) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: CustomColors.primaryLight),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: TW3Colors.gray.shade400,
              fontSize: 12,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            value,
            style: TextStyle(color: CustomColors.primary, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget buildSteps(String stepNumber, String desc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: CustomColors.primaryLight),
          child: Text(
            stepNumber,
            style: TextStyle(color: CustomColors.primary),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Flexible(
          child: Text(
            desc,
            style: TextStyle(fontSize: 12, color: TW3Colors.gray.shade500),
          ),
        )
      ],
    );
  }
}
