import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tez_projesi_android/constants/colors.dart';

enum ButtonType { primary, defaultType, text, link }

enum ButtonSize { xs, sm, md, lg, xl, xxl }

class ButtonComponent extends StatelessWidget {
  final String label;
  final ButtonType? type;
  final bool? block;
  final ButtonSize? size;
  final void Function()? onPressed;
  const ButtonComponent(
      {super.key,
      this.type = ButtonType.primary,
      this.block = false,
      required this.label,
      this.size = ButtonSize.md, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: type == ButtonType.primary ? CustomColors.primary : Colors.white,
          border: type == ButtonType.defaultType
              ? Border.all(
                  width: 2,
                  color: TWColors.gray.shade300,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: size!.index * 9, vertical: size!.index * 2.5),
        width: block == true ? MediaQuery.of(context).size.width : null,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: size == ButtonSize.xs ? 8 : size == ButtonSize.sm ? 10 : size == ButtonSize.md ? 14 : size == ButtonSize.lg ? 16 : size == ButtonSize.xl ? 18 : 20, 
            color: type == ButtonType.primary
                ? Colors.white
                : type == ButtonType.defaultType
                    ? TWColors.gray.shade400
                    : type == ButtonType.text
                        ? CustomColors.primary
                        : TWColors.blue.shade500,
          ),
        ),
      ),
    );
  }
}
