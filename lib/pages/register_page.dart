import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/components/button_component.dart';
import 'package:tez_projesi_android/components/input_component.dart';
import 'package:tez_projesi_android/constants/colors.dart';
import 'package:tez_projesi_android/pages/login_page.dart';
import 'package:tez_projesi_android/pages/promo_page4.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

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
                    "assets/illustrations/Login.png",
                    width: MediaQuery.of(context).size.width - 100,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Text(
                        "Kayıt Ol",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: TW3Colors.gray.shade900, fontSize: 24),
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Text(
                      "Uygulamaya devam etmek için lütfen kayıt olunuz",
                      style: TextStyle(
                        color: TWColors.gray.shade600,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: InputComponent(
                          hintText: "Adınız",
                          icon: FontAwesomeIcons.user,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: InputComponent(
                          hintText: "Soyadınız",
                          icon: FontAwesomeIcons.user,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const InputComponent(
                    hintText: "Emailinizi giriniz",
                    icon: FontAwesomeIcons.envelope,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const InputComponent(
                    hintText: "Parolanızı giriniz",
                    icon: FontAwesomeIcons.lock,
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const InputComponent(
                    hintText: "Parolanızı tekrar giriniz",
                    icon: FontAwesomeIcons.lock,
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: ButtonComponent(
                      label: "Kayıt Ol",
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
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Zaten bir hesabın var mı?",
                        style: TextStyle(
                            color: TW3Colors.gray.shade400, fontSize: 12),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage())),
                        child: const Text(
                          "Hemen Giriş Yap!",
                          style: TextStyle(
                            color: CustomColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
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
