import 'package:store_app/FieldsData/Service.dart';
import 'package:flutter/widgets.dart';

abstract class Field {
  const Field({required this.text, this.icon, required this.service});

  final String text;
  final IconData? icon;
  final Service service;

  String? validator(String? value) => null;
  void onChanged(String? value) {}
}

class NameField extends Field {
  NameField({required super.text, required super.service});

  @override
  String? validator(String? value) {
    return (value == null || value.isEmpty) ? 'Name is required' : null;
  }

  @override
  void onChanged(String? value) {
    service.fullName = value;
  }
}

class GenderField extends Field {
  const GenderField({required super.text, required super.service});
}

class EmailField extends Field {
  EmailField({required super.text, required super.service});

  @override
  String? validator(String? value) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@stud\.fci-cu\.edu\.eg$');
    return (value == null || !emailRegex.hasMatch(value))
        ? 'Invalid FCI email'
        : null;
  }

  @override
  void onChanged(String? value) {
    service.email = value;
  }
}

class StudentIDField extends Field {
  StudentIDField({required super.text, required super.service});

  @override
  String? validator(value) {
    if (value == null || value.isEmpty) {
      return 'Student ID is required';
    } else if (value != service.email.split('@').first) {
      return 'Email ID and student ID do not match';
    } else if (value.startsWith('0')) {
      return 'ID can\'t start with 0';
    } else {
      // check also if this4
    }
    return null;
  }

  @override
  void onChanged(String? value) {
    if (value != null && value.isNotEmpty) service.ID = int.parse(value);
  }
}

class PasswordField extends Field {
  PasswordField({required super.text, required super.service});

  @override
  String? validator(String? value) {
    if (value == null || value.length < 8 || !RegExp(r'\d').hasMatch(value)) {
      return 'Password must be at least 8 characters with 1 number';
    }
    return null;
  }

  @override
  void onChanged(String? value) {
    service.password = value;
  }
}

class ConfirmPasswordField extends Field {
  ConfirmPasswordField({required super.text, required super.service});

  @override
  String? validator(String? value) {
    return (value == null || value.length < 8 || value != service.password)
        ? 'Passwords must match and be at least 8 characters'
        : null;
  }

  @override
  void onChanged(String? value) {
    // signUpService.setObscurePassword2 = value;
  }
}

class OldPasswordField extends Field {
  OldPasswordField({required super.text, required super.service});

  @override
  void onChanged(String? value) {
    if (value != null) service.password = value;
  }

  @override
  String? validator(String? value) {
    return (value == null || value == '') ? 'Can\'t be empty' : null;
  }
}

class NewPasswordField extends Field {
  NewPasswordField({required super.text, required super.service});

  @override
  void onChanged(String? value) {
    if (value != null) service.confirmPassword = value;
  }

  @override
  String? validator(String? value) {
    return (value == null || value == '') ? 'Can\'t be empty' : null;
  }
}
