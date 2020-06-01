import 'package:email_validator/email_validator.dart';

class ValidationMixin {
  String validateEmail(String email) {
    return EmailValidator.validate(email) ? null : 'Invalid e-mail adrress';
  }

  String validatePassword(String password) {
    return password.length >= 4
        ? null
        : 'Password needs to have at least 4 characters';
  }
}
