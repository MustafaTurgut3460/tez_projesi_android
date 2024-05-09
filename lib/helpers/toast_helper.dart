import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:toastification/toastification.dart';

class ToastHelper {

  void show(String title, String desc, ToastificationType type, BuildContext context) {
    toastification.show(
        context: context,
        type: type,
        title: Text(
          title,
          style: TextStyle(color: TW3Colors.gray.shade700),
        ),
        autoCloseDuration: const Duration(seconds: 3),
        dragToClose: true,
        closeButtonShowType: CloseButtonShowType.none,
        description: Text(
          desc,
          style: TextStyle(
            fontSize: 11,
            color: TW3Colors.gray.shade500,
          ),
        ),
        showProgressBar: false,
        animationDuration: const Duration(milliseconds: 500));
  }

  void cancel() {
   toastification.dismissAll();
  }
}
