import 'package:flutter/material.dart';

dynamic commonSnackBar(
    {required String message, required BuildContext context}) {
  return WidgetsBinding.instance?.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
  });
}
