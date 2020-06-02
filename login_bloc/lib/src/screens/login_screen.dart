import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import '../blocs/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(context) {
    final bloc = Provider.of(context);

    return Container(
      margin: EdgeInsets.fromLTRB(20, 60, 20, 0),
      child: Column(
        children: <Widget>[
          emailField(bloc),
          Container(margin: const EdgeInsets.only(top: 15)),
          passwordField(bloc),
          Container(margin: const EdgeInsets.only(top: 40)),
          keepMeLoggedInCheckBox(),
          Container(margin: const EdgeInsets.only(top: 25)),
          submitButton(bloc),
        ],
      ),
    );
  }

  Widget emailField(Bloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.email,
        builder: (context, snapshot) {
          return TextField(
            decoration: InputDecoration(
              labelText: 'E-mail address',
              hintText: 'you@example.com',
              errorText: snapshot.error,
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: bloc.changeEmail,
          );
        });
  }

  Widget passwordField(Bloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.password,
        builder: (context, snapshot) {
          return TextField(
            decoration: InputDecoration(
              labelText: 'Password',
              errorText: snapshot.error,
            ),
            obscureText: true,
            onChanged: bloc.changePassword,
          );
        });
  }

  Widget keepMeLoggedInCheckBox() {
    return Text('checkbox placeholder');
  }

  Widget submitButton(Bloc bloc) {
    return StreamBuilder(
        stream: bloc.submitValid,
        builder: (context, snapshot) {
          return RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: Text('Submit'),
            onPressed: snapshot.hasData ? () {} : null,
          );
        });
  }
}
