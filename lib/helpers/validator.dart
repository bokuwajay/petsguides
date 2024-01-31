mixin Validator {
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$")
        .hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Phone numbers are required';
    } else if (!RegExp(r"^(?:\+852-?)?[456789]\d{3}-?\d{4}$").hasMatch(phone)) {
      return 'Please enter valid HK phone numbers';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    } else if (password.length < 12) {
      return 'Password must be at least 12 characters';
    } else if (!RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+")
        .hasMatch(password)) {
      return "Please include at least 1 uppercase, 1 lowercase and 1 digit.";
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    } else if (value != password) {
      return 'Confirm password does not match';
    }
    return null;
  }

  String? validateRequiredField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }
}
