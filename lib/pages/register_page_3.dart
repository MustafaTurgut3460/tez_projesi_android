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
import 'package:tez_projesi_android/pages/main_page.dart';
import 'package:tez_projesi_android/services/endpoints.dart';
import 'package:tez_projesi_android/services/general/http_service.dart';
import 'package:tez_projesi_android/services/general/storage_service.dart';
import 'package:toastification/toastification.dart';

class RegisterPage3 extends StatefulWidget {
  const RegisterPage3({super.key});

  @override
  State<RegisterPage3> createState() => _RegisterPage3State();
}

class _RegisterPage3State extends State<RegisterPage3> {
  var cuisineList = List<CuisineItem>.empty();
  var selectedCuisineList = List<CuisineItem>.empty();
  var displayList = List<CuisineItem>.empty();
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

    getHealts().then((value) => {
          setState(() {
            cuisineList = value;
          })
        });
  }

  void _onSearchChanged() {
    if (_searchController.text.length > 2) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        getHealts(searchText: _searchController.text).then((value) => {
              setState(() {
                cuisineList = value;
              })
            });
      });

      setState(() {
        displayList = cuisineList;
      });
    } else {
      setState(() {
        displayList = selectedCuisineList;
      });
    }
  }

  Future<List<CuisineItem>> getHealts(
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
                        buildStepNumbers("2", false),
                        const SizedBox(
                          width: 8,
                        ),
                        buildStepNumbers("3", true),
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
                  "Sevdiğiniz ülke mutfakları nelerdir?",
                  style: TextStyle(
                      color: TW3Colors.gray.shade800,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  "İşaretlediğiniz mutfaklara göre öneriler alacaksınız, lütfen aşağıdaki bölümlerden sevdiğiniz mutfakları seçiniz.",
                  style:
                      TextStyle(color: TW3Colors.gray.shade400, fontSize: 12),
                ),
                const SizedBox(
                  height: 10,
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
                      children: displayList.map((cuisineItem) {
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
                    )
                  ],
                ),
                const SizedBox(
                  height: 80,
                ),
                ButtonComponent(
                  label: "Tamamla",
                  block: true,
                  size: ButtonSize.lg,
                  onPressed: () async {
                    var data = selectedCuisineList.map((e) => e.id).toList();

                    final res = await httpService
                        .post(Endpoints.addUserInfo(), {"cuisines": data});

                    await StorageService.saveData("is-registered", "true");

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage()));

                             toaster.show(
                        "Kayıt Başarılı",
                        "Girdiğiniz bilgiler ile kayıt başarıyla gerçekleştirildi",
                        ToastificationType.success,
                        context);
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
