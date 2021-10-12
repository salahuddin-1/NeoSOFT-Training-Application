class ResetPasswordValidation {
  static String? currentPassword(String val) {
    if (val.isEmpty) {
      return "Please enter your current password";
    }

    return null;
  }

  static String? newPassword(String val) {
    if (val.isEmpty) {
      return 'Password cannot be empty';
    } else if (val.length > 20) {
      return 'Password too long';
    } else if (val.length < 10) {
      return 'Password too short';
    }
    return null;
  }

  static String? confirmPassword(String val1, String val2) {
    if (val1 != val2) {
      return "Passwords do not match";
    }

    return null;
  }
}
