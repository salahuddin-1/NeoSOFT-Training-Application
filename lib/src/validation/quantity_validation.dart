class QuantityValidation {
  static bool isQuantityValidate(String val) {
    if (val.isEmpty) {
      return false;
    } else if (val.length > 1 || val.contains('0') || val.contains('9')) {
      return false;
    }

    return true;
  }
}
