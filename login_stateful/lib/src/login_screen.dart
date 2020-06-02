import 'package:flutter/material.dart';
import './mixins/validation_mixin.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>  with ValidationMixin{
  final formKey = GlobalKey<FormState>();

  String email, password;
  bool keepMeLoggedIn;

  @override
  Widget build(context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            emailField(),
            Container(margin: const EdgeInsets.only(top: 15)),
            passwordField(),
            Container(margin: const EdgeInsets.only(top: 25)),
            submitButton(),

          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'E-mail address',
        hintText: 'you@example.com',
      ),
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
      onSaved: (String value) => email = value,
    );
  }

  Widget passwordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
      ),
      obscureText: true,
      validator: validatePassword,
      onSaved: (String value) => password = value,
    );
  }

  Widget submitButton() {
    return RaisedButton(
      color: Colors.blue,
      textColor: Colors.white,
      child: Text('Submit'),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print('values saved: $email///$password');
        }
      },
    );
  }
}
