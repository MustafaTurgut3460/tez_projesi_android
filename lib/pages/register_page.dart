import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/components/button_component.dart';
import 'package:tez_projesi_android/components/input_component.dart';
import 'package:tez_projesi_android/constants/colors.dart';
import 'package:tez_projesi_android/helpers/toast_helper.dart';
import 'package:tez_projesi_android/pages/login_page.dart';
import 'package:tez_projesi_android/pages/register_page_1.dart';
import 'package:tez_projesi_android/services/endpoints.dart';
import 'package:tez_projesi_android/services/general/http_service.dart';
import 'package:tez_projesi_android/services/general/storage_service.dart';
import 'package:toastification/toastification.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var controllers = {
    "nameController": TextEditingController(),
    "surnameController": TextEditingController(),
    "emailController": TextEditingController(),
    "passwordController": TextEditingController(),
    "passwordAgainController": TextEditingController(),
  };
  final toaster = ToastHelper();
  final httpService = HttpService();
  var loading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllers["nameController"]!.dispose();
    controllers["surnameController"]!.dispose();
    controllers["emailController"]!.dispose();
    controllers["passwordController"]!.dispose();
    controllers["passwordAgainController"]!.dispose();
  }

  

  Future<void> handleSubmit() async {
    final values = getControllersValues(controllers);

    if (values["password"]!.isEmpty ||
        values["passwordAgain"]!.isEmpty ||
        values["name"]!.isEmpty ||
        values["surname"]!.isEmpty ||
        values["email"]!.isEmpty) {
      toaster.show("Hatalı İstek", "Lütfen tüm birimleri doldurunuz",
          ToastificationType.error, context);
      return;
    }

    if (values["password"] != values["passwordAgain"]) {
      toaster.show("Parolalar Eşleşmiyor", "Lütfen parolayı kontrol ediniz",
          ToastificationType.error, context);
      return;
    }

    setState(() {
      loading = true;
    });

    final data = {
      "name": values["name"],
      "surname": values["surname"],
      "email": values["email"],
      "userName": values["email"],
      "password": values["password"]
    };

    final response = await httpService.post(Endpoints.register(), data);

    if (!response.status) {
      toaster.show("Hata", response.body["messages"][0],
          ToastificationType.error, context);
    } else {
      final data = response.body["data"];
      final user = {
        "id": data["id"],
        "name": data["name"],
        "email": data["email"]
      };

      await StorageService.saveData("current-user", jsonEncode(user));

      final loginRes = await httpService.post(Endpoints.login(),
          {"email": values["email"], "password": values["password"]});

      setState(() {
        loading = false;
      });

      if (!loginRes.status) {
        toaster.show("Hata", response.body["messages"][0],
            ToastificationType.error, context);
        return;
      }

      toaster.show(
          "Kayıt Başarılı",
          "Kayıt olma işlemi başarıyla gerçekleştirildi",
          ToastificationType.success,
          context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const RegisterPage1()));
    }
  }

  Map<String, String> getControllersValues(
      Map<String, TextEditingController> controllers) {
    var data = {
      "name": controllers["nameController"]!.text,
      "surname": controllers["surnameController"]!.text,
      "email": controllers["emailController"]!.text,
      "password": controllers["passwordController"]!.text,
      "passwordAgain": controllers["passwordController"]!.text,
    };

    return data;
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
                  Row(
                    children: [
                      Expanded(
                        child: InputComponent(
                          hintText: "Adınız",
                          icon: FontAwesomeIcons.user,
                          controller: controllers["nameController"],
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: InputComponent(
                          hintText: "Soyadınız",
                          icon: FontAwesomeIcons.user,
                          controller: controllers["surnameController"],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputComponent(
                    hintText: "Emailinizi giriniz",
                    icon: FontAwesomeIcons.envelope,
                    controller: controllers["emailController"],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputComponent(
                    hintText: "Parolanızı giriniz",
                    icon: FontAwesomeIcons.lock,
                    controller: controllers["passwordController"],
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputComponent(
                    hintText: "Parolanızı tekrar giriniz",
                    icon: FontAwesomeIcons.lock,
                    controller: controllers["passwordAgainController"],
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
                      onPressed: handleSubmit,
                      loading: loading,
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
