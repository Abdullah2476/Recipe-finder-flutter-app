class AppValidators {
  /// Validates that a field is not empty.
  static String? validateEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName.';
    }
    return null;
  }

  /// Validates an email address format.
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email.';
    }
    // A simple regex for email validation. Can be made more robust if needed.
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  /// Validates a password's le
  static String? validatePassword(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password.';
    }
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters long.';
    }
    return null;
  }

  /// Validates a general name field.
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name.';
    }

    return null;
  }
}
