import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/components/button_component.dart';
import 'package:tez_projesi_android/components/chip_component.dart';
import 'package:tez_projesi_android/components/input_component.dart';
import 'package:tez_projesi_android/constants/colors.dart';
import 'package:tez_projesi_android/helpers/toast_helper.dart';
import 'package:tez_projesi_android/models/ai_recipe.dart';
import 'package:tez_projesi_android/models/cuisine_item.dart';
import 'package:tez_projesi_android/models/food_item.dart';
import 'package:tez_projesi_android/models/health_item.dart';
import 'package:tez_projesi_android/models/meal_item.dart';
import 'package:tez_projesi_android/pages/ai_recipe_detail_page.dart';
import 'package:tez_projesi_android/pages/recipe_detail_page.dart';
import 'package:tez_projesi_android/services/endpoints.dart';
import 'package:tez_projesi_android/services/general/http_service.dart';

class CreateAiRecipePage extends StatefulWidget {
  final String type;
  const CreateAiRecipePage({super.key, required this.type});

  @override
  State<CreateAiRecipePage> createState() => _CreateAiRecipePageState();
}

class _CreateAiRecipePageState extends State<CreateAiRecipePage> {
  var loading = false;
  var typeList = List<String>.empty();
  var cuisineList = List<CuisineItem>.empty();
  var selectedCuisineList = List<CuisineItem>.empty();
  var cuisineDisplayList = List<CuisineItem>.empty();
  final _cuisineSearchController = TextEditingController();

  var foodList = List<FoodItem>.empty();
  var selectedFoodList = List<FoodItem>.empty();
  var foodDisplayList = List<FoodItem>.empty();
  final _foodSearchController = TextEditingController();

  var mealList = [
    MealItem(id: "1", name: "Kahvaltı"),
    MealItem(id: "2", name: "Öğle Yemeği"),
    MealItem(id: "3", name: "Akşam Yemeği"),
    MealItem(id: "4", name: "Atıştırmalık"),
  ];

  var selectedMealList = List<MealItem>.empty();

  final dynamic meals = [
    {"id": "1", "name": "Kahvaltı"},
    {"id": "2", "name": "Öğle Yemeği"},
    {"id": "3", "name": "Akşam Yemeği"},
    {"id": "4", "name": ":Atıştırmalık"},
  ];

  final httpService = HttpService();
  Timer? _debounce;
  final toaster = ToastHelper();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cuisineSearchController.dispose();
    _foodSearchController.dispose();
    _debounce?.cancel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      typeList = [...typeList, widget.type];
    });

    _cuisineSearchController.addListener(_onCuisineSearchChanged);
    _foodSearchController.addListener(_onFoodSearchChanged);

    if (widget.type == "location") {
      getCusines().then((value) => {
            setState(() {
              cuisineList = value;
              cuisineDisplayList = value;
            })
          });
    } else if (widget.type == "food") {
      getFoods().then((value) => {
            setState(() {
              foodList = value;
              foodDisplayList = value;
            })
          });
    }
  }

  void _onCuisineSearchChanged() {
    if (_cuisineSearchController.text.length > 2) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        getCusines(searchText: _cuisineSearchController.text).then((value) => {
              setState(() {
                cuisineList = value;
              })
            });
      });

      setState(() {
        cuisineDisplayList = cuisineList;
      });
    } else {
      setState(() {
        cuisineDisplayList = selectedCuisineList;
      });
    }
  }

  void _onFoodSearchChanged() {
    if (_foodSearchController.text.length > 2) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        getFoods(searchText: _foodSearchController.text).then((value) => {
              setState(() {
                foodList = value;
              })
            });
      });

      setState(() {
        foodDisplayList = foodList;
      });
    } else {
      setState(() {
        foodDisplayList = selectedFoodList;
      });
    }
  }

  Future<List<CuisineItem>> getCusines(
      {String? searchText, int? page, int? pageSize}) async {
    final response = await httpService.get(Endpoints.getCuisines(
        searchText: searchText, page: page, pageSize: pageSize));

    if (response.status) {
      var list = response.body['data'] as List;
      List<CuisineItem> dataList =
          list.map((i) => CuisineItem.fromJson(i)).toList();

      return dataList;
    }

    return List<CuisineItem>.empty();
  }

  Future<List<FoodItem>> getFoods(
      {String? searchText, int? page, int? pageSize}) async {
    final response = await httpService.get(Endpoints.getFoods(
        searchText: searchText, page: page, pageSize: pageSize));

    if (response.status) {
      var list = response.body['data'] as List;
      List<FoodItem> dataList = list.map((i) => FoodItem.fromJson(i)).toList();

      return dataList;
    }

    return List<FoodItem>.empty();
  }

  Future<void> createRecipe() async {
    String empty = "";
    setState(() {
      loading = true;
    });
    var data = {
      "cuisine": selectedCuisineList.isEmpty ? empty : selectedCuisineList[0].name,
      "mealType": selectedMealList.isEmpty ? empty : selectedMealList[0].name,
      "includedIngredients": selectedFoodList.isEmpty ? [] : selectedFoodList.map((item) => item.name).toList(),
      "excludedIngredients": [],
      "health": [],
      "language": "Turkish",
    };

    final response = await httpService.post(Endpoints.createAiRecipe(), data);

    final recipe = AiRepcipe.fromJson(response.body["data"]);

    setState(() {
      loading = false;
    });

    Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AiRecipeDetailPage(recipe: recipe,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    "assets/illustrations/${widget.type}.png",
                    width: MediaQuery.of(context).size.width - 100,
                    height: MediaQuery.of(context).size.width - 100,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              widget.type == "multifilter"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ButtonComponent(
                          onPressed: () => {
                            if (typeList.contains("location"))
                              {
                                setState(() {
                                  typeList.remove("location");
                                })
                              }
                            else
                              {
                                setState(() {
                                  typeList = [...typeList, "location"];
                                })
                              }
                          },
                          label: "Bölge",
                          type: typeList.contains("location") ? ButtonType.primary : ButtonType.text,
                        ),
                        ButtonComponent(
                          onPressed: () => {
                            if (typeList.contains("food"))
                              {
                                setState(() {
                                  typeList.remove("food");
                                })
                              }
                            else
                              {
                                setState(() {
                                  typeList = [...typeList, "food"];
                                })
                              }
                          },
                          label: "Malzeme",
                          type: typeList.contains("food") ? ButtonType.primary : ButtonType.text,
                        ),
                        ButtonComponent(
                          onPressed: () => {
                            if (typeList.contains("meal"))
                              {
                                setState(() {
                                  typeList.remove("meal");
                                })
                              }
                            else
                              {
                                setState(() {
                                  typeList = [...typeList, "meal"];
                                })
                              }
                          },
                          label: "Öğün",
                          type: typeList.contains("meal") ? ButtonType.primary : ButtonType.text,
                        ),
                      ],
                    )
                  : const SizedBox(),
              SizedBox(
                height: 20,
              ),
              typeList.contains("location")
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bölge Seçin",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Lütfen aşağıda bulunan bölgelerden istediğiniz bölgeleri seçiniz. Yapay zeka bu seçilen bölgelere göre yemek önerecektir.",
                          style: TextStyle(
                              fontSize: 14, color: TW3Colors.gray.shade500),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InputComponent(
                          hintText: "Mutfak Arayın...",
                          icon: FontAwesomeIcons.search,
                          bgColor: TW3Colors.gray.shade100,
                          controller: _cuisineSearchController,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Wrap(
                          runAlignment: WrapAlignment.spaceBetween,
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            Wrap(
                              runAlignment: WrapAlignment.spaceBetween,
                              spacing: 8,
                              runSpacing: 8,
                              children: cuisineDisplayList.map((cuisineItem) {
                                return InkWell(
                                  onTap: () => {
                                    setState(() {
                                      cuisineItem.isSelected =
                                          !cuisineItem.isSelected;
                                      selectedCuisineList = [
                                        ...selectedCuisineList,
                                        cuisineItem
                                      ];
                                    })
                                  },
                                  child: ChipComponent(
                                      isSelected: cuisineItem.isSelected,
                                      text: cuisineItem.name),
                                );
                              }).toList(),
                            ),
                          ],
                        )
                      ],
                    )
                  : const SizedBox(),
              typeList.contains("food")
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Malzeme Seçin",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Lütfen aşağıda bulunan bölgelerden istediğiniz bölgeleri seçiniz. Yapay zeka bu seçilen bölgelere göre yemek önerecektir.",
                          style: TextStyle(
                              fontSize: 14, color: TW3Colors.gray.shade500),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InputComponent(
                          hintText: "Malzeme Arayın...",
                          icon: FontAwesomeIcons.search,
                          bgColor: TW3Colors.gray.shade100,
                          controller: _foodSearchController,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Wrap(
                          runAlignment: WrapAlignment.spaceBetween,
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            Wrap(
                              runAlignment: WrapAlignment.spaceBetween,
                              spacing: 8,
                              runSpacing: 8,
                              children: foodDisplayList.map((foodItem) {
                                return InkWell(
                                  onTap: () => {
                                    setState(() {
                                      foodItem.isSelected =
                                          !foodItem.isSelected;
                                      selectedFoodList = [
                                        ...selectedFoodList,
                                        foodItem
                                      ];
                                    })
                                  },
                                  child: ChipComponent(
                                      isSelected: foodItem.isSelected,
                                      text: foodItem.name),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ],
                    )
                  : const SizedBox(),
              typeList.contains("meal")
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Öğün Seçin",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Lütfen aşağıda bulunan bölgelerden istediğiniz bölgeleri seçiniz. Yapay zeka bu seçilen bölgelere göre yemek önerecektir.",
                          style: TextStyle(
                              fontSize: 14, color: TW3Colors.gray.shade500),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Wrap(
                          runAlignment: WrapAlignment.spaceBetween,
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            Wrap(
                              runAlignment: WrapAlignment.spaceBetween,
                              spacing: 8,
                              runSpacing: 8,
                              children: mealList.map((mealItem) {
                                return InkWell(
                                  onTap: () => {
                                    setState(() {
                                      mealItem.isSelected =
                                          !mealItem.isSelected;
                                      selectedMealList = [
                                        ...selectedMealList,
                                        mealItem
                                      ];
                                    })
                                  },
                                  child: ChipComponent(
                                      isSelected: mealItem.isSelected,
                                      text: mealItem.name),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ],
                    )
                  : const SizedBox(),
              SizedBox(
                height: 50,
              ),
              ButtonComponent(
                label: "Yemek Tarifi Oluştur",
                size: ButtonSize.xl,
                block: true,
                onPressed: () => createRecipe(),
                loading: loading,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
