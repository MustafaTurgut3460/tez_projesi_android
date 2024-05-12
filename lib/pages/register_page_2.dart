import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/components/button_component.dart';
import 'package:tez_projesi_android/components/chip_component.dart';
import 'package:tez_projesi_android/components/input_component.dart';
import 'package:tez_projesi_android/constants/colors.dart';
import 'package:tez_projesi_android/models/health_item.dart';
import 'package:tez_projesi_android/pages/register_page_3.dart';
import 'package:tez_projesi_android/services/endpoints.dart';
import 'package:tez_projesi_android/services/general/http_service.dart';
import 'package:tez_projesi_android/services/general/storage_service.dart';

class RegisterPage2 extends StatefulWidget {
  const RegisterPage2({super.key});

  @override
  State<RegisterPage2> createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  var healthList = List<HealthItem>.empty();
  var selectedHealthList = List<HealthItem>.empty();
  var displayList = List<HealthItem>.empty();
  final httpService = HttpService();
  final _searchController = TextEditingController();
  Timer? _debounce;

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

    _searchController.addListener(_onSearchChanged);

    getHealts().then((value) => {
          setState(() {
            healthList = value;
          })
        });
  }

  void _onSearchChanged() {
    if (_searchController.text.length > 2) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        getHealts(searchText: _searchController.text).then((value) => {
              setState(() {
                healthList = value;
              })
            });
      });

      setState(() {
        displayList = healthList;
      });
    } else {
      setState(() {
        displayList = selectedHealthList;
      });
    }
  }

  Future<List<HealthItem>> getHealts(
      {String? searchText, int? page, int? pageSize}) async {
    final response = await httpService.get(Endpoints.getHealts(
        searchText: searchText, page: page, pageSize: pageSize));

    if (response.status) {
      var list = response.body['data'] as List;
      List<HealthItem> dataList =
          list.map((i) => HealthItem.fromJson(i)).toList();

      return dataList;
    }

    return List<HealthItem>.empty();
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
                        buildStepNumbers("1", false),
                        const SizedBox(
                          width: 8,
                        ),
                        buildStepNumbers("2", true),
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
                  "Uygulamanız gereken bir diyet veya yeme alışkanlığı var mı?",
                  style: TextStyle(
                      color: TW3Colors.gray.shade800,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  "Bir rahatsızlığınız varsa veya yemek alışkanlığınız varsa lütfen aşağıdaki bölümden bunları seçiniz",
                  style:
                      TextStyle(color: TW3Colors.gray.shade400, fontSize: 12),
                ),
                const SizedBox(
                  height: 10,
                ),
                InputComponent(
                  hintText: "Diyet Arayın...",
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
                      children: displayList.map((healthItem) {
                        return InkWell(
                          onTap: () => {
                            setState(() {
                              healthItem.isSelected = !healthItem.isSelected;
                              selectedHealthList = [
                                ...selectedHealthList,
                                healthItem
                              ];
                            })
                          },
                          child: ChipComponent(
                              isSelected: healthItem.isSelected,
                              text: healthItem.name),
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
                    var data = selectedHealthList.map((e) => e.id).toList();

                    final res = await httpService
                        .post(Endpoints.addUserInfo(), {"healts": data});

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage3()));
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
