import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/components/button_component.dart';
import 'package:tez_projesi_android/components/chip_component.dart';
import 'package:tez_projesi_android/components/input_component.dart';
import 'package:tez_projesi_android/constants/colors.dart';
import 'package:tez_projesi_android/pages/main_page.dart';

class RegisterPage3 extends StatefulWidget {
  const RegisterPage3({super.key});

  @override
  State<RegisterPage3> createState() => _RegisterPage3State();
}

class _RegisterPage3State extends State<RegisterPage3> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                ),
                const SizedBox(
                  height: 24,
                ),
                const Wrap(
                  runAlignment: WrapAlignment.spaceBetween,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ChipComponent(isSelected: true, text: "Asya"),
                    ChipComponent(isSelected: false, text: "Avrupa"),
                    ChipComponent(isSelected: false, text: "Orta Doğu"),
                    ChipComponent(isSelected: false, text: "Türk"),
                    ChipComponent(isSelected: false, text: "Latin Amerika"),
                  ],
                ),
                const SizedBox(height: 80,),
                ButtonComponent(label: "Tamamla", block: true, size: ButtonSize.lg, onPressed: () {
                  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage()));
                },)
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
