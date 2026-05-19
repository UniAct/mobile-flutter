import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/utils/app_exception.dart';
import 'package:mobile_flutter/core/widgets/app_toast.dart';

class AppHelpers {
  static void showMessage(BuildContext context, String message) {
    showInfo(context, message);
  }

  static void showSuccess(BuildContext context, String message) {
    AppToast.show(context, message: message, type: AppToastType.success);
  }

  static void showError(BuildContext context, String message) {
    AppToast.show(context, message: message, type: AppToastType.error);
  }

  static void showWarning(BuildContext context, String message) {
    AppToast.show(context, message: message, type: AppToastType.warning);
  }

  static void showInfo(BuildContext context, String message) {
    AppToast.show(context, message: message, type: AppToastType.info);
  }

  static String userErrorMessage(Object error) {
    if (error is AppException) {
      return error.message;
    }

    final raw = error.toString();
    if (raw.startsWith('Exception: ')) {
      return raw.replaceFirst('Exception: ', '').trim();
    }

    return raw;
  }
}
