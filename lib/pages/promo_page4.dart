import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/components/button_component.dart';
import 'package:tez_projesi_android/components/dot_component.dart';
import 'package:tez_projesi_android/constants/colors.dart';
import 'package:tez_projesi_android/pages/login_page.dart';

class PromoPage4 extends StatelessWidget {
  const PromoPage4({super.key});

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
                  "assets/illustrations/Promo4.png",
                  width: MediaQuery.of(context).size.width - 100,
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                            text: "Kendi evinin ",
                            style: TextStyle(
                              color: TWColors.gray.shade800,
                            ),
                          ),
                          TextSpan(
                              text: "şefi ",
                              style: TextStyle(color: CustomColors.primary)),
                          TextSpan(
                            text: "olmaya hazır mısın?",
                            style: TextStyle(
                              color: TWColors.gray.shade800,
                            ),
                          ),
                        ],
                      ),
                    )),
                    SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("Yeni lezzetlere adım atmak için kayıt ol! Ya da hesabın varsa giriş yap!", style: TextStyle(
                        color: TWColors.gray.shade600,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,),
                    ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: [
                      ButtonComponent(
                        label: "Kayıt Ol",
                        block: true,
                        type: ButtonType.primary,
                        size: ButtonSize.xl,
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PromoPage4())),
                      ),
                      SizedBox(height: 8,),
                      ButtonComponent(
                        label: "Giriş Yap",
                        block: true,
                        type: ButtonType.secondary,
                        size: ButtonSize.xl,
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage())),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
