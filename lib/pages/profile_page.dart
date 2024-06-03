import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/constants/colors.dart';
import 'package:tez_projesi_android/pages/login_page.dart';
import 'package:tez_projesi_android/services/general/storage_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Image.asset(
            "assets/images/efsanevi.png",
            height: MediaQuery.of(context).size.width / 3,
            width: MediaQuery.of(context).size.width / 3,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Mustafa Turgut",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "mustafa.turgut3460@gmail.com",
            style: TextStyle(fontSize: 14, color: TW3Colors.gray.shade500),
          ),
          SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () async => {
              await StorageService.deleteToken(),
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (Route<dynamic> route) => false,
              ),
            },
            child: Text(
              "Çıkış Yap",
              style: TextStyle(fontSize: 16, color: TW3Colors.red.shade500),
            ),
          ),
        ],
      ),
    ));
  }
}
