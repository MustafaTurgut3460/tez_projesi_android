import 'package:flutter/material.dart';
import 'package:tez_projesi_android/constants/colors.dart';

class DotComponent extends StatelessWidget {
  final double size;
  final bool filled;
  const DotComponent({super.key, required this.size, required this.filled});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: filled ? CustomColors.primary : CustomColors.primaryLight,
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ));
  }
}
