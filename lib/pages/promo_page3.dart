import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/components/button_component.dart';
import 'package:tez_projesi_android/components/dot_component.dart';
import 'package:tez_projesi_android/constants/colors.dart';
import 'package:tez_projesi_android/pages/promo_page4.dart';

class PromoPage3 extends StatelessWidget {
  const PromoPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Tanıtımı Geç",
                      style: TextStyle(color: TWColors.gray.shade500),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    FaIcon(
                      FontAwesomeIcons.arrowRight,
                      size: 16,
                      color: TWColors.gray.shade500,
                    )
                  ],
                ),
                SizedBox(
                  height: 48,
                ),
                Image.asset(
                  "assets/illustrations/Promo3.png",
                  width: MediaQuery.of(context).size.width - 100,
                ),
                SizedBox(height: 16,),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 22,
                          color: TWColors.gray.shade800, // Genel metin rengi
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Kendi ",
                            style: TextStyle(
                              color: TWColors.gray.shade800,
                            ),
                          ),
                          TextSpan(
                              text: "tariflerini paylaş ",
                              style: TextStyle(color: CustomColors.primary)),
                          TextSpan(
                            text: "ve diğer kullanıcılar ile etkileşime gir!",
                            style: TextStyle(
                              color: TWColors.gray.shade800,
                            ),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: ButtonComponent(
                    label: "Sonraki",
                    block: true,
                    type: ButtonType.primary,
                    size: ButtonSize.xl,
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PromoPage4())),
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DotComponent(size: 8, filled: false),
                    SizedBox(
                      width: 8,
                    ),
                    DotComponent(size: 8, filled: false),
                    SizedBox(
                      width: 8,
                    ),
                    DotComponent(size: 8, filled: true),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
