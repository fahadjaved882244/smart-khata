import 'package:get/get_utils/src/get_utils/get_utils.dart';

class AuthValidator {
  static String? nameValidator(String? value) {
    if (value != null) {
      final trimed = value.trim();
      if (trimed.length < 3) {
        return 'Required';
      } else {
        return null;
      }
    } else {
      return 'Required';
    }
  }

  static const _emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  static String? emailValidator(String? value) {
    if (value != null) {
      final trimed = value.trim();
      if (trimed.isEmpty) {
        return 'Required';
      } else if (RegExp(_emailRegex).hasMatch(trimed)) {
        return null;
      } else {
        return 'Invalid Email';
      }
    } else {
      return 'Required';
    }
  }

  static String? passwordValidator(String? value) {
    if (value != null) {
      final trimed = value.trim();
      if (trimed.isEmpty) {
        return 'Required';
      } else if (trimed.length < 8) {
        return 'Weak Password';
      } else {
        return null;
      }
    } else {
      return 'Required';
    }
  }

  static String? loginPasswordValidator(String? value) {
    if (value != null) {
      final trimed = value.trim();
      if (trimed.isEmpty) {
        return 'Required';
      } else {
        return null;
      }
    } else {
      return 'Required';
    }
  }

  static String? unitValidator(String? value) {
    if (value != null) {
      final trimed = value.trim();
      if (trimed.isNotEmpty) {
        return null;
      } else {
        return 'Required';
      }
    } else {
      return 'Required';
    }
  }

  static String? phoneValidator(String? value) {
    if (value != null) {
      final trimed = value.trim();
      if (trimed.isEmpty) {
        return 'Required';
      } else if (trimed.length == 10 && GetUtils.isPhoneNumber(trimed)) {
        return null;
      } else {
        return 'Invalid Phone Number';
      }
    } else {
      return 'Required';
    }
  }

  static String? otpValidator(String? v) {
    if (v != null && v.length < 4) {
      return "Required";
    } else {
      return null;
    }
  }

  static String? phoneValidatorOptional(String? value) {
    if (value != null) {
      final trimed = value.trim();
      if (trimed.isEmpty) {
        return 'Required';
      } else if (GetUtils.isPhoneNumber(trimed)) {
        return null;
      } else {
        return 'Invalid Phone Number';
      }
    } else {
      return null;
    }
  }

  static String? optionalEmailValidator(String? value) {
    if (value != null) {
      final trimed = value.trim();
      if (trimed.isEmpty) {
        return null;
      } else if (RegExp(_emailRegex).hasMatch(trimed)) {
        return null;
      } else {
        return 'Invalid Email';
      }
    } else {
      return null;
    }
  }

  static String? optionalPhoneValidator(String? value) {
    if (value != null) {
      final trimed = value.trim();
      if (trimed.isEmpty) {
        return null;
      } else if (GetUtils.isPhoneNumber(trimed)) {
        return null;
      } else {
        return 'Invalid Phone Number';
      }
    } else {
      return null;
    }
  }

  static String? promoCodeValidator(String? value) {
    if (value != null) {
      final trimed = value.trim();
      if (trimed.length < 8) {
        return 'Invalid Code';
      } else {
        return null;
      }
    } else {
      return 'Required';
    }
  }
}
