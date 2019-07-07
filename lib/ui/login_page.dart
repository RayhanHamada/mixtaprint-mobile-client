import 'package:flutter/material.dart';
import 'package:mixtaprint_mobile_client/resources/auth.dart';
import 'package:mixtaprint_mobile_client/ui/signup_page.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = "", _password = "";

  @override
  void initState() {
    super.initState();
  }

  void doLogin() async
  {
    if (_formKey.currentState.validate()){
      _formKey.currentState.save();

      String snackBarMsg; // message for snackbar
      bool success = false; // is login success

      // authentication using firebase here
      await Auth.login(_email, _password).then((callback) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(callback['msg'])));
        if (callback['status']) toHomePage();
        print(callback['msg']);
        print(callback['status']);
      });


    }
  }

  void toHomePage()
  {
    // TODO: code for go to homepage
    print('done!!!');
  }

  void toSignUpPage()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
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
                        hintText: 'Please Enter Your Email'),
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
                        hintText: 'Please Enter Your Password'),
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
                      color: Colors.black
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
