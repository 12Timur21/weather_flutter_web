import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class ToastBox {
  const ToastBox._();
  static const ToastBox instance = ToastBox._();

  void showErrorToast({
    required BuildContext context,
    required String text,
  }) {
    MotionToast.error(
      title: const Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      description: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      position: MOTION_TOAST_POSITION.bottom,
      width: MediaQuery.of(context).size.width * 0.8,
    ).show(context);
  }
}
