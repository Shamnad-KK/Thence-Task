import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:thence_task/data/model/error_model.dart';

import '../theme/app_colors.dart';
import '../core/pop_ups.dart';

final ErrorModel error = ErrorModel(errorMessage: 'Something went wrong');

class AppExceptions {
  static void handleError(Object exception) {
    if (exception is DioError) {
      if (exception.error is SocketException) {
        error.errorMessage = "Please check your connection";
        AppPopUps.showToast(error.errorMessage, AppColors.errorColor);
        return;
      } else if (exception.error is PlatformException) {
        error.errorMessage = "Platform Exception";
        AppPopUps.showToast(error.errorMessage, AppColors.errorColor);
        return;
      } else if (exception.type == DioErrorType.cancel) {
        error.errorMessage = "Request cancelled";
        AppPopUps.showToast(error.errorMessage, AppColors.errorColor);
        return;
      } else if (exception.type == DioErrorType.connectTimeout) {
        error.errorMessage = "Connection time out";
        AppPopUps.showToast(error.errorMessage, AppColors.errorColor);
        return;
      } else if (exception.type == DioErrorType.receiveTimeout) {
        error.errorMessage = "Recieve time out";
        AppPopUps.showToast(error.errorMessage, AppColors.errorColor);
        return;
      } else if (exception.type == DioErrorType.sendTimeout) {
        error.errorMessage = "Send time out";
        AppPopUps.showToast(error.errorMessage, AppColors.errorColor);
        return;
      } else if (exception.type == DioErrorType.other) {
        error.errorMessage = "Error Occured";
        AppPopUps.showToast(error.errorMessage, AppColors.errorColor);
        return;
      } else if (exception.type == DioErrorType.response) {
        error.errorMessage = "Response Error occured";
        AppPopUps.showToast(error.errorMessage, AppColors.errorColor);
        return;
      }
    }
    if (exception is SocketException) {
      error.errorMessage = "Please check your connection";
      AppPopUps.showToast(error.errorMessage, AppColors.errorColor);
      return;
    }
    if (exception is TimeoutException) {
      error.errorMessage = "Time out";
      AppPopUps.showToast(error.errorMessage, AppColors.errorColor);
      return;
    } else if (exception is PlatformException) {
      error.errorMessage = "Platform Exception";
      AppPopUps.showToast(exception.message.toString(), AppColors.errorColor);
      return;
    } else {
      AppPopUps.showToast(exception.toString(), AppColors.errorColor);
      log(exception.toString());
      return;
    }
  }
}
