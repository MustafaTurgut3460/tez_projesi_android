import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/components/button_component.dart';
import 'package:tez_projesi_android/components/dot_component.dart';
import 'package:tez_projesi_android/constants/colors.dart';

class PromoPage1 extends StatelessWidget {
  const PromoPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/illustrations/Promo1.png",
                width: MediaQuery.of(context).size.width - 100,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 22,
                        color: TWColors.gray.shade800, // Genel metin rengi
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: "Yeni ",
                          style: TextStyle(
                              color: Colors
                                  .red), // "Yeni" kelimesi için farklı renk
                        ),
                        TextSpan(
                          text:
                              "yemekler ve insanlar keşfet, kendini yemek dünyasında geliştir!",
                          // Bu kısım genel stil ayarlarına (yukarıda belirtilen) tabi olacak
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: ButtonComponent(
                  label: "Sonraki",
                  block: true,
                  type: ButtonType.primary,
                  size: ButtonSize.xl,
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DotComponent(size: 8, filled: true),
                  SizedBox(
                    width: 8,
                  ),
                  DotComponent(size: 8, filled: false),
                  SizedBox(
                    width: 8,
                  ),
                  DotComponent(size: 8, filled: false),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
