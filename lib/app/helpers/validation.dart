import 'package:get/get_utils/src/get_utils/get_utils.dart';

class Validation {
  String? validationEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Email not valid';
    }
    return null;
  }

  String? validationName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validationAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your address';
    }
    return null;
  }

  String? validationPhonenumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phonenumber';
    }
    return null;
  }

  String? validationPassword(String? value) {
    if (value == null || value.length < 6) {
      return 'Password must be longer than 6 characters.\n';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Uppercase letter is missing.\n';
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Lowercase letter is missing.\n';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Digit is missing.\n';
    }

    if (!value.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      return 'Special character is missing.\n';
    }

    return null;
  }

  String? validationconfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm password field must be filled';
    }
    if (password != confirmPassword) {
      return 'Confirm password not match';
    }

    // If there are no error messages, the password is valid
    return null;
  }
}
