class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    final nameRegex = RegExp(r"^[a-zA-Z]+(?:[\s'-][a-zA-Z]+)*$");
    if (!nameRegex.hasMatch(value.trim())) {
      return 'Enter a valid name (only letters, spaces, hyphens, or apostrophes allowed)';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final numericRegex = RegExp(r'^[0-9]+$');
    if (!numericRegex.hasMatch(value)) {
      return 'Enter a valid number';
    }

    if (value.length < 10) {
      return 'Phone number must be at least 10 digits';
    }

    return null;
  }

  static String? validateAddress(String? value) {
    return (value == null || value.trim().isEmpty)
        ? 'Address is required'
        : null;
  }

  static String? validateFoodName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Food name is required';
    }
    if (value.trim().length < 3) {
      return 'Food name must be at least 3 characters';
    }
    return null;
  }
}
