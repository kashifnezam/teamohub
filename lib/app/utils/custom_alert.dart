import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

import '../../main.dart';
import '../utils/app_colors.dart';

class CustomAlert {
  /// Safely get context
  static BuildContext? get _context {
    if (navigatorKey.currentContext == null ||
        !navigatorKey.currentState!.mounted) {
      debugPrint("Alert context unavailable");
      return null;
    }
    return navigatorKey.currentContext;
  }

  //--------------------------------------------------
  // Success Alert
  //--------------------------------------------------

  static void successAlert(
      String text, {
        String? title,
        String confirmText = "OK",
        Color? confirmBtnColor,
      }) {
    final context = _context;
    if (context == null) return;

    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: title,
      text: text,
      confirmBtnText: confirmText,
      confirmBtnColor: confirmBtnColor ?? AppColors.secondary,
    );
  }

  //--------------------------------------------------
  // Error Alert
  //--------------------------------------------------

  static void errorAlert(
      String text, {
        String title = "Error",
        String confirmText = "OK",
        Color? confirmBtnColor,
      }) {
    final context = _context;
    if (context == null) return;

    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: title,
      text: text,
      confirmBtnText: confirmText,
      confirmBtnColor: confirmBtnColor ?? AppColors.secondary,
    );
  }

  //--------------------------------------------------
  // Loading Alert
  //--------------------------------------------------

  static void loadAlert(String text) {
    final context = _context;
    if (context == null) return;

    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      text: text,
      barrierDismissible: false,
    );
  }

  //--------------------------------------------------
  // Dismiss Alert
  //--------------------------------------------------

  static void dismissAlert() {
    final context = _context;
    if (context == null) return;

    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  //--------------------------------------------------
  // Confirmation Alert
  //--------------------------------------------------

  static Future<bool> confirmAlert(
      String text, {
        String title = "Confirm",
        String confirmText = "Yes",
        String cancelText = "No",
        Color? confirmBtnColor,
      }) async {
    final context = _context;
    if (context == null) return false;

    final completer = Completer<bool>();

    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: title,
      text: text,
      confirmBtnText: confirmText,
      cancelBtnText: cancelText,
      confirmBtnColor: confirmBtnColor ?? AppColors.secondary,
      barrierDismissible: false,
      onConfirmBtnTap: () {
        if (!completer.isCompleted) {
          completer.complete(true);
        }
        dismissAlert();
      },
      onCancelBtnTap: () {
        if (!completer.isCompleted) {
          completer.complete(false);
        }
        dismissAlert();
      },
    );

    return completer.future;
  }

  //--------------------------------------------------
  // Custom Alert
  //--------------------------------------------------

  static void customAlert({
    required QuickAlertType type,
    required String text,
    String? title,
    String confirmBtnText = "OK",
    Color? confirmBtnColor,
    VoidCallback? onConfirm,
  }) {
    final context = _context;
    if (context == null) return;

    QuickAlert.show(
      context: context,
      type: type,
      title: title,
      text: text,
      confirmBtnText: confirmBtnText,
      confirmBtnColor: confirmBtnColor ?? AppColors.secondary,
      onConfirmBtnTap: onConfirm,
    );
  }

  //--------------------------------------------------
  // Info Alert
  //--------------------------------------------------

  static void infoAlert(
      String text, {
        String title = "Info",
        int autoCloseSeconds = 3,
      }) {
    final context = _context;
    if (context == null) return;

    QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      title: title,
      text: text,
      autoCloseDuration: Duration(seconds: autoCloseSeconds),
      showConfirmBtn: false,
    );
  }
}