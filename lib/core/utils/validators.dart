class Validators {
  static String? requiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? nationalId(String? value) {
    final required = requiredField(value, 'National ID');
    if (required != null) {
      return required;
    }

    final safeValue = value?.trim() ?? '';

    final digitsOnly = RegExp(r'^\d{14}$');
    if (!digitsOnly.hasMatch(safeValue)) {
      return 'National ID must be 14 digits';
    }
    return null;
  }

  static String? email(String? value) {
    final required = requiredField(value, 'Email');
    if (required != null) {
      return required;
    }

    final safeValue = value?.trim() ?? '';
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(safeValue)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? password(String? value) {
    final required = requiredField(value, 'Password');
    if (required != null) {
      return required;
    }

    final safeValue = value?.trim() ?? '';

    if (safeValue.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
