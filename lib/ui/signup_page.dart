import 'package:flutter/material.dart';

import 'login_page.dart';
import 'package:mixtaprint_mobile_client/resources/auth.dart';

class SignUpPage extends StatefulWidget {

  static final routeName = '/SignUpPage';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final _tffPassKey = GlobalKey<FormFieldState<String>>();
  final _tffPassValKey = GlobalKey<FormFieldState<String>>();
  final _tffEmailKey = GlobalKey<FormFieldState<String>>();

  String _email, _password, _inAppUsername;

  void doSignUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      await Auth.signUp(_inAppUsername, _email, _password).then((ret) async {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text(ret['msg'])));
        if (ret['clr_email_field']) {
          _tffEmailKey.currentState.reset();
        }
        if (ret['clr_pass_field']) {
          _tffPassKey.currentState.reset();
          _tffPassValKey.currentState.reset();
        }
        await Future.delayed(Duration(seconds: 2));
        if (ret['status']) {
          _formKey.currentState.reset();
          toLoginPage();
        }
      });
    }
  }

  void toLoginPage() {
    setState(() {
      Navigator.pop(context);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.lightBlue[100], Colors.lightBlue[700]],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Myriad Pro',
                      fontSize: 26),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    onSaved: (input) {
                      setState(() {
                        _inAppUsername = input;
                      });
                    },
                    validator: (text) {
                      if (text.isEmpty) return "Username cannot be empty";
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      icon: Icon(
                        Icons.people_outline,
                        color: Colors.white,
                      ),
                      hintText: 'Username',
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    key: _tffEmailKey,
                    onSaved: (input) {
                      setState(() {
                        _email = input;
                      });
                    },
                    validator: (text) {
                      if (text.isEmpty) return "Email field cannot be empty";
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      icon: Icon(
                        Icons.mail_outline,
                        color: Colors.white,
                      ),
                      hintText: 'Email',
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    key: _tffPassKey,
                    onSaved: (input) {
                      setState(() {
                        _password = input;
                      });
                    },
                    validator: (text) {
                      if (text.isEmpty)
                        return "Password field cannot be empty";
                      else if (text.length < 8)
                        return "Password must at least 8 character long";
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      icon: Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                      ),
                      hintText: 'Password',
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    key: _tffPassValKey,
                    onSaved: (input) {},
                    validator: (text) {
                      if (text.isEmpty)
                        return "Validator Password field cannot be empty";
                      if (text != _tffPassKey.currentState.value)
                        return "Repeated password is not same";
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      icon: Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                      ),
                      hintText: 'Validate Password',
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: RaisedButton(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                    onPressed: doSignUp,
                    color: Colors.orangeAccent[700],
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: OutlineButton(
                    child: Text(
                      'Already have an account ?',
                    ),
                    borderSide: BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: toLoginPage,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
