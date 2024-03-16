import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/components/button_component.dart';
import 'package:tez_projesi_android/pages/promo_page4.dart';

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
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Image.asset(
                    "assets/illustrations/Login.png",
                    width: MediaQuery.of(context).size.width - 100,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Uygulamaya devam etmek için lütfen giriş yapınız",
                      style: TextStyle(
                        color: TWColors.gray.shade600,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextField(
                    decoration: buildTextFieldStyle()
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: ButtonComponent(
                      label: "Giriş Yap",
                      block: true,
                      type: ButtonType.primary,
                      size: ButtonSize.xl,
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PromoPage4())),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration buildTextFieldStyle() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: TW3Colors.gray.shade200,
      hintStyle: TextStyle(
        color: TW3Colors.gray.shade400
      )
    );
  }
}
