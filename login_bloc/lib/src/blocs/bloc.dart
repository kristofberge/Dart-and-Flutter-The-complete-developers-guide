import 'dart:async';
import './validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc with Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // Add date to stream
  get changeEmail => _email.sink.add;
  get changePassword => _password.sink.add;

  // Retrieve data from stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get submitValid =>
      CombineLatestStream.combine2<String, String, bool>(
          _email.stream, _password.stream, (e, p) => e == _email.value && p == _password.value);

  dispose() {
    _email.close();
    _password.close();
  }
}
