import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class InputComponent extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final bool? isPassword;
  const InputComponent({super.key, this.hintText, this.icon, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: TW3Colors.gray.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon == null
              ? const SizedBox()
              : FaIcon(
                  icon,
                  size: 16,
                  color: TW3Colors.gray.shade400,
                ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextField(
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: TW3Colors.gray.shade400)),
                  obscureText: isPassword ?? false,
            ),
          ),
        ],
      ),
    );
  }
}