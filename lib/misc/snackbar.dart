import 'package:flutter/material.dart';

import 'snackbar_enum.dart';

class CustomSnackbar {
  static void show(BuildContext context, SnackBarType type, String message) {
    Color snackBarColor;
    Color fillColor;
    IconData icon;
    Duration showDuration;

    switch (type) {
      case SnackBarType.Error:
        snackBarColor = Colors.red[400]!;
        icon = Icons.error_outline;
        fillColor = Colors.white;
        showDuration = const Duration(seconds: 3);
        break;
      case SnackBarType.Success:
        snackBarColor = Colors.green[600]!;
        icon = Icons.check_circle_outline;
        fillColor = Colors.white;
        showDuration = const Duration(milliseconds: 700);
        break;
      case SnackBarType.Warning:
        snackBarColor = Colors.yellow[700]!;
        icon = Icons.change_circle_outlined;
        fillColor = Colors.white;
        showDuration = const Duration(seconds: 1);
        break;
      case SnackBarType.Info:
        snackBarColor = Colors.white;
        icon = Icons.info_outline;
        fillColor = Colors.black;
        showDuration = const Duration(seconds: 5);
        break;
      default:
        snackBarColor = Colors.white;
        icon = Icons.change_circle_outlined;
        fillColor = Colors.black;
        showDuration = const Duration(seconds: 3);
    }

    var snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            icon,
            color: fillColor,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              message,
              style: TextStyle(color: fillColor),
            ),
          ),
        ],
      ),
      clipBehavior: Clip.none,
      duration: showDuration,
      closeIconColor: fillColor,
      showCloseIcon: true,
      elevation: 5,
      backgroundColor: snackBarColor,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
