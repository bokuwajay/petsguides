mixin Validator {
  String? validateEmail(String? email, String fieldName) {
    if (email == null || email.isEmpty) {
      if (RegExp(r'^[a-zA-Z]+$').hasMatch(fieldName)) {
        return 'Email is required';
      } else {
        return '請填寫有效的電郵地址';
      }
    } else if (!RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
    ).hasMatch(email)) {
      if (RegExp(r'^[a-zA-Z]+$').hasMatch(fieldName)) {
        return 'Please enter a valid email';
      } else {
        return '請填寫有效的電郵地址';
      }
    }
    return null;
  }

  String? validatePhone(String? phone, String fieldName) {
    if (phone == null || phone.isEmpty) {
      if (RegExp(r'^[a-zA-Z]+$').hasMatch(fieldName)) {
        return 'Phone numbers are required';
      } else {
        return "請填寫有效的香港電話號碼";
      }
    } else if (!RegExp(r"^(?:\+852-?)?[456789]\d{3}-?\d{4}$").hasMatch(phone)) {
      return 'Please enter valid HK phone numbers';
    }
    return null;
  }

  String? validatePassword(String? password, String fieldName) {
    if (password == null || password.isEmpty) {
      if (RegExp(r'^[a-zA-Z]+$').hasMatch(fieldName)) {
        return 'Password is required';
      } else {
        return "請填寫密碼";
      }
    } else if (password.length < 12) {
      if (RegExp(r'^[a-zA-Z]+$').hasMatch(fieldName)) {
        return 'Password must be at least 12 characters';
      } else {
        return '密碼最少為12個英文字母(最少1個大楷及1個細楷)及數字';
      }
    } else if (!RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+")
        .hasMatch(password)) {
      if (RegExp(r'^[a-zA-Z]+$').hasMatch(fieldName)) {
        return "Please include at least 1 uppercase, 1 lowercase and 1 digit.";
      } else {
        return '密碼最少1個大楷及1個細楷字母及數字';
      }
    }
    return null;
  }

  String? validateConfirmPassword(
      String? value, String password, String fieldName) {
    if (value == null || value.isEmpty) {
      if (RegExp(r'^[a-zA-Z]+$').hasMatch(fieldName)) {
        return 'Confirm password is required';
      } else {
        return '請重覆上述所設定的密碼';
      }
    } else if (value != password) {
      if (RegExp(r'^[a-zA-Z]+$').hasMatch(fieldName)) {
        return 'Confirm password does not match';
      } else {
        return '與上述所設定的密碼不符，請重新輸入';
      }
    }
    return null;
  }

  String? validateRequiredField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      if (RegExp(r'^[a-zA-Z]+$').hasMatch(fieldName)) {
        return '$fieldName is required';
      } else {
        return '$fieldName不可留空';
      }
    }
    return null;
  }
}
