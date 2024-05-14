import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/constants/colors.dart';
import 'package:tez_projesi_android/models/recipe.dart';
import 'package:tez_projesi_android/pages/recipe_detail_page.dart';
import 'package:tez_projesi_android/services/endpoints.dart';
import 'package:tez_projesi_android/services/general/http_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final httpService = HttpService();
  List<Recipe> recipeList = List<Recipe>.empty();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getRecipes().then((value) => {
          setState(() {
            recipeList = value;
          })
        });
  }

  Future<List<Recipe>> getRecipes(
      {String? searchText, int? page, int? pageSize}) async {
    final response = await httpService.get(Endpoints.getRecipes(
        searchText: searchText, page: page, pageSize: pageSize));

    if (response.status) {
      var list = response.body['data'] as List;
      List<Recipe> dataList = list.map((i) => Recipe.fromJson(i)).toList();

      return dataList;
    }

    return List<Recipe>.empty();
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(
                        recipeList.isNotEmpty ? recipeList[0].imageUrl : ""),
                    opacity: 0.9,
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
                    Opacity(
                      opacity: 0.8,
                      child: Text(
                        recipeList.isNotEmpty ? recipeList[0].title : "",
                        style: const TextStyle(
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
                        Opacity(
                          opacity: 0.7,
                          child: Text(
                            recipeList.isNotEmpty
                                ? recipeList[0].user.name
                                : "",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
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
                    for (int i = 0; i < recipeList.length; i++) ...[
                      buildFoodComponent(
                        recipeList[i],
                      ),
                      if (i != recipeList.length - 1) const SizedBox(width: 8),
                    ]
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
                    for (int i = 0; i < recipeList.length; i++) ...[
                      buildFoodComponent(
                        recipeList[i],
                      ),
                      if (i != recipeList.length - 1) const SizedBox(width: 8),
                    ]
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

  Widget buildFoodComponent(Recipe recipe) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RecipesDetailPage(recipe: recipe))),
      child: Column(
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(4), // Resmin köşelerini yuvarlamak için
            child: Image.network(
              recipe.imageUrl,
              height: 48,
              width: 64,
              fit: BoxFit.cover, // Resmi kutuya sığdırmak için
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            "${recipe.title.substring(0, 10)}...",
            style: TextStyle(fontSize: 12, color: TW3Colors.gray.shade500),
          )
        ],
      ),
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
