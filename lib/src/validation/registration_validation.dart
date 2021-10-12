class ValidationRegister {
  static String? firstName(String val) {
    if (val.isEmpty) {
      return 'First name cannot be empty';
    } else if (val.length > 15) {
      return 'Too long';
    } else if (val.length < 3) {
      return 'Too short';
    }
    return null;
  }

  static String? lastName(String val) {
    if (val.isEmpty) {
      return 'Last name cannot be empty';
    } else if (val.length > 15) {
      return 'Too long';
    } else if (val.length < 3) {
      return 'Too short';
    }
    return null;
  }

  static String? email(String val) {
    if (val.isEmpty) {
      return 'Email cannot be empty';
    } else if (!isEmail(val)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static bool isEmail(String val) {
    if (val.contains('@') && (val.contains('.com') || val.contains('.in'))) {
      return true;
    }

    return false;
  }

  static String? password(String val) {
    if (val.isEmpty) {
      return 'Password cannot be empty';
    } else if (val.length > 20) {
      return 'Password too long';
    } else if (val.length < 10) {
      return 'Password too short';
    }
    return null;
  }

  static String? conPassword(String val, String val2) {
    if (val != val2) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? phoneNumber(String val) {
    if (val.isEmpty) {
      return 'Phone no. cannot be empty';
    } else if (!val.contains(RegExp("^[0-9]+\$"))) {
      return 'Enter a valid phone no.';
    } else if (val.length != 10) {
      return 'Phone no. should be of 10 digits';
    }
    return null;
  }
}
