class AddressValidation {
  static String? address(String val) {
    if (val.isEmpty) {
      return "Address cannot be empty";
    } else if (val.length > 100) {
      return 'Address too long';
    }

    return null;
  }

  static String? landmark(String val) {
    if (val.isEmpty) {
      return "Landmark cannot be empty";
    } else if (val.length > 15) {
      return 'Landmark too long';
    }

    return null;
  }

  static String? city(String val) {
    if (val.isEmpty) {
      return "City cannot be empty";
    } else if (val.length > 15) {
      return 'City too long';
    }

    return null;
  }

  static String? state(String val) {
    if (val.isEmpty) {
      return "State cannot be empty";
    } else if (val.length > 15) {
      return 'State too long';
    }

    return null;
  }

  static String? zipcode(String val) {
    if (val.isEmpty) {
      return "Zipcode cannot be empty";
    } else if (val.length > 15) {
      return 'Zipcode too long';
    }

    return null;
  }

  static String? country(String val) {
    if (val.isEmpty) {
      return "Country cannot be empty";
    } else if (val.length > 15) {
      return 'Country too long';
    }

    return null;
  }
}
