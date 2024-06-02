import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/components/button_component.dart';
import 'package:tez_projesi_android/components/chip_component.dart';
import 'package:tez_projesi_android/components/input_component.dart';
import 'package:tez_projesi_android/constants/colors.dart';
import 'package:tez_projesi_android/helpers/toast_helper.dart';
import 'package:tez_projesi_android/models/cuisine_item.dart';
import 'package:tez_projesi_android/services/endpoints.dart';
import 'package:tez_projesi_android/services/general/http_service.dart';

class CreateAiRecipePage extends StatefulWidget {
  final String type;
  const CreateAiRecipePage({super.key, required this.type});

  @override
  State<CreateAiRecipePage> createState() => _CreateAiRecipePageState();
}

class _CreateAiRecipePageState extends State<CreateAiRecipePage> {
  var typeList = List<String>.empty();
  var cuisineList = List<CuisineItem>.empty();
  var selectedCuisineList = List<CuisineItem>.empty();
  var cuisineDisplayList = List<CuisineItem>.empty();
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
    typeList.add(widget.type);

    _searchController.addListener(_onSearchChanged);

    getCusines().then((value) => {
          setState(() {
            cuisineList = value;
            cuisineDisplayList = value;
          })
        });
  }

  void _onSearchChanged() {
    if (_searchController.text.length > 2) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        getCusines(searchText: _searchController.text).then((value) => {
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
                style: TextStyle(fontSize: 14, color: TW3Colors.gray.shade500),
              ),
              SizedBox(
                height: 20,
              ),
              InputComponent(
                hintText: "Mutfak Arayın...",
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
                    children: cuisineDisplayList.map((cuisineItem) {
                      return InkWell(
                        onTap: () => {
                          setState(() {
                            cuisineItem.isSelected = !cuisineItem.isSelected;
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
              ),
              SizedBox(
                height: 50,
              ),
              ButtonComponent(
                label: "Yemek Tarifi Oluştur",
                size: ButtonSize.xl,
                block: true,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
