import 'package:flutter/material.dart';

import 'login_page.dart';


class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormFieldState> _formKey = GlobalKey<FormFieldState>();

  GlobalKey<FormFieldState<String>> _tffPassword = GlobalKey<FormFieldState<String>>();
  GlobalKey<FormFieldState<String>> _tffPassValidate = GlobalKey<FormFieldState<String>>();

  String _email, _password, _passwordValidate;

  void doSignUp()
  {
    if (_formKey.currentState.validate()){
      _formKey.currentState.save();
    }
  }

  void toLoginPage()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
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
                end: Alignment.bottomCenter
            )
        ),
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
                        hintText: 'Please Enter Your Email'),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    key: _tffPassword,
                    onSaved: (input) {
                      setState(() {
                        _password = input;
                      });
                    },
                    validator: (text) {
                      if (text.isEmpty) return "Password field cannot be empty";
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        icon: Icon(
                          Icons.lock_outline,
                          color: Colors.white,
                        ),
                        hintText: 'Please Enter Your Password'),
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    key: _tffPassValidate,
                    onSaved: (input) {
                      setState(() {
                        _passwordValidate = input;
                      });
                    },
                    validator: (text) {
                      if (text.isEmpty) return "Validator Password field cannot be empty";
                      if (text != _tffPassword.currentState.value) return "Repeated password is not same";
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        icon: Icon(
                          Icons.lock_outline,
                          color: Colors.white,
                        ),
                        hintText: 'Please Enter Your Password Again'),
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
                    borderSide: BorderSide(
                        color: Colors.black
                    ),
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
