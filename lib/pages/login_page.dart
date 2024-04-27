import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/components/button_component.dart';
import 'package:tez_projesi_android/components/input_component.dart';
import 'package:tez_projesi_android/constants/colors.dart';
import 'package:tez_projesi_android/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          padding: const EdgeInsets.all(32.0),
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
                        "Giriş Yap",
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
                      "Uygulamaya devam etmek için lütfen giriş yapınız",
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
                  const InputComponent(
                    hintText: "Emailinizi giriniz",
                    icon: FontAwesomeIcons.envelope,
                  ),
                  // TextField(
                  //   decoration: buildTextFieldStyle(),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  const InputComponent(
                    hintText: "Parolanızı giriniz",
                    icon: FontAwesomeIcons.lock,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Şifreni mi Unuttun?",
                      style: TextStyle(
                          color: TW3Colors.gray.shade500, fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: ButtonComponent(
                      label: "Giriş Yap",
                      block: true,
                      type: ButtonType.primary,
                      size: ButtonSize.xl,
                      onPressed: () => {
                        // login islemleri
                      }
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Henüz bir hesabın yok mu?",
                        style: TextStyle(
                            color: TW3Colors.gray.shade400, fontSize: 12),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()));
                        },
                        child: const Text(
                          "Hemen Oluştur!",
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
