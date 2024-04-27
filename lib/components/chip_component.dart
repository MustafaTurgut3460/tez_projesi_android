import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/constants/colors.dart';

class ChipComponent extends StatelessWidget {
  final bool isSelected;
  final String text;
  final IconData? icon;

  const ChipComponent(
      {super.key, required this.isSelected, required this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color:
                  isSelected ? CustomColors.primary : TW3Colors.gray.shade400,
              width: 1),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? CustomColors.primary : Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon == null
              ? const SizedBox()
              : FaIcon(
                  icon,
                  size: 12,
                  color: isSelected ? Colors.white : TW3Colors.gray.shade400,
                ),
          SizedBox(
            width: icon == null ? 0 : 4,
          ),
          Text(
            text,
            style: TextStyle(
                color: isSelected ? Colors.white : TW3Colors.gray.shade500,
                fontSize: 12),
          )
        ],
      ),
    );
  }
}
