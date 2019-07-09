import 'package:flutter/material.dart';
import 'package:mixtaprint_mobile_client/resources/auth.dart';
import 'package:mixtaprint_mobile_client/ui/signup_page.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {

  static final routeName = '/LoginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String _email = "", _password = "";

  @override
  void initState() {
    super.initState();
  }

  void doLogin() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      // authentication using firebase here
      await Auth.login(_email, _password).then((ret) async {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text(ret['msg'])));
        await Future.delayed(Duration(seconds: 2));
        if (ret['status'])
          toHomePage();
        else
          _formKey.currentState.reset();
      });
    }
  }

  void toHomePage() {
    setState(() {
      Navigator.pushNamed(context, HomePage.routeName);
    });
  }

  void toSignUpPage() {
    setState(() {
      Navigator.pushNamed(context, SignUpPage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
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
                  'Login',
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
                      hintText: 'Email',
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
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
                      hintText: 'Password',
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: RaisedButton(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                    onPressed: doLogin,
                    color: Colors.orangeAccent[700],
                  ),
                ),
                SizedBox(
                  width: 170,
                  child: OutlineButton(
                    child: Text(
                      'Don\'t have any account ?',
                    ),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: toSignUpPage,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
