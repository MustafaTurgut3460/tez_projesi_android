// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/components/button_component.dart';
import 'package:tez_projesi_android/components/input_component.dart';
import 'package:tez_projesi_android/constants/colors.dart';
import 'package:tez_projesi_android/helpers/toast_helper.dart';
import 'package:tez_projesi_android/pages/main_page.dart';
import 'package:tez_projesi_android/pages/register_page.dart';
import 'package:tez_projesi_android/pages/register_page_1.dart';
import 'package:tez_projesi_android/services/endpoints.dart';
import 'package:tez_projesi_android/services/general/http_service.dart';
import 'package:tez_projesi_android/services/general/storage_service.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final toaster = ToastHelper();
  bool loginLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Future<void> initState() async {
    // TODO: implement initState
    super.initState();
    StorageService.getToken().then((value) => {
          if (value != "")
            {
              StorageService.getData("is-registered").then((value) => {
                    if (value != null)
                      {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MainPage()))
                      }
                    else
                      {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RegisterPage1()))
                      }
                  })
            }
        });
  }

  Future<void> submitLogin() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      toaster.show("Hatalı Giriş", "Lütfen tüm birimleri doldurunuz",
          ToastificationType.warning, context);
    }

    final httpService = HttpService();
    final data = {"email": email, "password": password};

    setState(() {
      loginLoading = true;
    });

    final response = await httpService.post(Endpoints.login(), data);

    if (!response.status) {
      toaster.show("Hata", response.body["messages"][0],
          ToastificationType.error, context);
    } else {
      // kullaniciyi iceri al ve tokeni kaydet
      final token = response.body["data"]["token"];
      await StorageService.saveToken(token);

      setState(() {
        loginLoading = false;
      });

      toaster.show(
          "Giriş Başarılı",
          "Giriş yapma işlemi başarıyla gerçekleştirildi",
          ToastificationType.success,
          context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const MainPage()));
    }
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
                  InputComponent(
                    hintText: "Emailinizi giriniz",
                    icon: FontAwesomeIcons.envelope,
                    controller: emailController,
                  ),
                  // TextField(
                  //   decoration: buildTextFieldStyle(),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputComponent(
                    hintText: "Parolanızı giriniz",
                    icon: FontAwesomeIcons.lock,
                    isPassword: true,
                    controller: passwordController,
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
                        submitLogin()
                      },
                      loading: loginLoading,
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
