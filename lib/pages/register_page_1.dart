import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/components/button_component.dart';
import 'package:tez_projesi_android/components/chip_component.dart';
import 'package:tez_projesi_android/components/input_component.dart';
import 'package:tez_projesi_android/constants/colors.dart';
import 'package:tez_projesi_android/helpers/toast_helper.dart';
import 'package:tez_projesi_android/models/food_item.dart';
import 'package:tez_projesi_android/pages/register_page_2.dart';
import 'package:tez_projesi_android/services/endpoints.dart';
import 'package:tez_projesi_android/services/general/http_service.dart';
import 'package:tez_projesi_android/services/general/storage_service.dart';
import 'package:toastification/toastification.dart';

class RegisterPage1 extends StatefulWidget {
  const RegisterPage1({super.key});

  @override
  State<RegisterPage1> createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
  var foodList = List<FoodItem>.empty();
  var selectedFoodList = List<FoodItem>.empty();
  var displayList = List<FoodItem>.empty();
  final httpService = HttpService();
  final _searchController = TextEditingController();
  Timer? _debounce;
  final toaster = ToastHelper();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
    _debounce?.cancel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _searchController.addListener(_onSearchChanged);

    getFoods().then((value) => {
          setState(() {
            foodList = value;
          })
        });
  }

  void _onSearchChanged() {
    if (_searchController.text.length > 2) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        getFoods(searchText: _searchController.text).then((value) => {
              setState(() {
                foodList = value;
              })
            });
      });

      setState(() {
        displayList = foodList;
      });
    } else {
      setState(() {
        displayList = selectedFoodList;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        buildStepNumbers("1", true),
                        const SizedBox(
                          width: 8,
                        ),
                        buildStepNumbers("2", false),
                        const SizedBox(
                          width: 8,
                        ),
                        buildStepNumbers("3", false),
                      ],
                    ),
                    const InkWell(
                      child: Text(
                        "Adımı Geç",
                        style: TextStyle(
                            color: CustomColors.primary,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Herhangi bir malzemeye veya ürüne alerjiniz var mı?",
                  style: TextStyle(
                      color: TW3Colors.gray.shade800,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  "Yediğinizde size zarar verebilecek malzemeleri olabildiğince sizden uzak tutmaya çalışıyoruz, lütfen aşağıdaki bölümden bu malzemeleri seçiniz.",
                  style:
                      TextStyle(color: TW3Colors.gray.shade400, fontSize: 12),
                ),
                const SizedBox(
                  height: 10,
                ),
                InputComponent(
                  hintText: "Malzeme Arayın...",
                  icon: FontAwesomeIcons.search,
                  bgColor: TW3Colors.gray.shade100,
                  controller: _searchController,
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
                      children: displayList.map((foodItem) {
                        return InkWell(
                          onTap: () => {
                            setState(() {
                              foodItem.isSelected = !foodItem.isSelected;
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
                const SizedBox(
                  height: 80,
                ),
                ButtonComponent(
                  label: "Sonraki Adım",
                  block: true,
                  size: ButtonSize.lg,
                  onPressed: () async {
                    var data = selectedFoodList.map((e) => e.id).toList();
                    final res = await httpService
                        .post(Endpoints.addUserInfo(), {"ingredients": data});

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage2()));

                   
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStepNumbers(String number, bool selected) {
    return (Container(
      width: 18.0,
      height: 18.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: selected ? CustomColors.primary : TW3Colors.gray.shade400,
              width: 1)),
      child: Center(
        child: Text(
          number, // Buraya istediğiniz numarayı yazabilirsiniz
          style: TextStyle(
            color: selected ? CustomColors.primary : TW3Colors.gray.shade400,
            fontSize: 12, // Numaranın font boyutu
          ),
        ),
      ),
    ));
  }
}
