import 'package:delightful_toast/delight_toast.dart';
import 'package:flutter/material.dart';

enum ToastStatus { searchCleared, addedToFavorite, removedFromFavorite }

class CustomToast {
  static void show(BuildContext context, {required ToastStatus status}) {
    IconData icon;
    Color iconColor;
    String message;

    switch (status) {
      case ToastStatus.searchCleared:
        icon = Icons.search_off;
        iconColor = Colors.amber;
        message = "Search Cleared";
        break;
      case ToastStatus.addedToFavorite:
        icon = Icons.favorite;
        iconColor = const Color.fromARGB(255, 199, 150, 255);
        message = "Added to Favorites";
        break;
      case ToastStatus.removedFromFavorite:
        icon = Icons.delete;
        iconColor = const Color.fromARGB(255, 228, 102, 93);
        message = "Removed from Favorites";
        break;
    }

    DelightToastBar(
      animationDuration: const Duration(milliseconds: 700),
      autoDismiss: true,
      snackbarDuration: Duration(milliseconds: 1300),
      builder: (context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 260,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff413066).withOpacity(0.95),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: iconColor),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: iconColor, size: 22),
                    const SizedBox(width: 12),
                    Text(
                      message,
                      style: TextStyle(
                        color: iconColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ).show(context);
  }
}
