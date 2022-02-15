import 'dart:async';
import 'package:khata/data/models/user.dart';
import 'package:khata/modules/components/popups/custom_snack_bar.dart';

import 'auth_exceptions.dart';

class AuthService {
  FutureOr<UserModel?> handleError(Object error) {
    if (error is ServerException) {
      showCustomSnackBar(message: error.message, isError: true);
    } else if (error is CredentialException) {
      showCustomSnackBar(message: error.message, isError: true);
    } else if (error is EmailException) {
      showCustomSnackBar(message: error.message, isError: true);
    } else if (error is PasswordException) {
      showCustomSnackBar(message: error.message, isError: true);
    } else if (error is AccountLockedException) {
      showCustomSnackBar(message: error.message, isError: true);
    } else if (error is AccountNotVerifiedException) {
      showCustomSnackBar(message: error.message, isError: true);
    } else if (error is AccountNotVerifiedException) {
      showCustomSnackBar(message: error.message, isError: true);
    } else if (error is NoUserFoundException) {
      showCustomSnackBar(message: error.message, isError: true);
    } else if (error is InvalidPhoneException) {
      showCustomSnackBar(message: error.message, isError: true);
    } else if (error is InvalidOTPCode) {
      showCustomSnackBar(message: error.message, isError: true);
    }
    return null;
  }
}
