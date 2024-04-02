import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/components/button_component.dart';

class EmailConfirmPage extends StatelessWidget {
  const EmailConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/illustrations/ConfirmEmail.png",
                    width: MediaQuery.of(context).size.width - 100,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Text(
                        "Doğrulama Linki Gönderildi",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: TW3Colors.gray.shade700, fontSize: 18),
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Text(
                      "E posta adresinize bir doğrulama linki gönderdik, lütfen bu link üzerinden e posta adresinizi doğrulayınız",
                      style: TextStyle(
                        color: TW3Colors.gray.shade500,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 40,),
                  ButtonComponent(
                    label: "Hadi Başlayalım",
                    onPressed: () {},
                    size: ButtonSize.xl,
                    block: true,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
