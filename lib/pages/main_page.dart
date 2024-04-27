import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/constants/colors.dart';
import 'package:tez_projesi_android/pages/ai_page.dart';
import 'package:tez_projesi_android/pages/home_page.dart';
import 'package:tez_projesi_android/pages/profile_page.dart';
import 'package:tez_projesi_android/pages/recipes_page.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const AIPage(),
    const RecipesPage(),
    const ProfilePage(),
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(selectedIndex),
      bottomNavigationBar: buildBottomBar(),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget buildBottomBar() {
    return FlashyTabBar(
      items: [
        FlashyTabBarItem(
            icon: SvgPicture.asset('assets/icons/home.svg', color: TW3Colors.gray.shade400,),
            title: const Text("Tarifler"),
            activeColor: CustomColors.primary),
        FlashyTabBarItem(
            icon: SvgPicture.asset('assets/icons/ai.svg', color: TW3Colors.gray.shade400,),
            title: const Text("Yapay Zeka"),
            activeColor: CustomColors.primary),
        FlashyTabBarItem(
            icon: SvgPicture.asset('assets/icons/recipes.svg', color: TW3Colors.gray.shade400,),
            title: const Text("Tariflerim"),
            activeColor: CustomColors.primary),
        FlashyTabBarItem(
            icon: SvgPicture.asset('assets/icons/profile.svg', color: TW3Colors.gray.shade400,),
            title: const Text("Profilim"),
            activeColor: CustomColors.primary),
      ],
      selectedIndex: selectedIndex,
      showElevation: true,
      onItemSelected: onItemTapped,
      animationDuration: const Duration(milliseconds: 200),
    );
  }
}
