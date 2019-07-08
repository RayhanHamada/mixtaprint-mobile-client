import 'package:flutter/material.dart';
import 'package:mixtaprint_mobile_client/resources/auth.dart';

import 'login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> _onBackPressed() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Logout and exit to login page'),
            content: Text('Are you sure ?'),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      'Yes',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: _toLoginPageAndLogout,
                  ),
                  Container(
                    width: 30,
                  ),
                  RaisedButton(
                    child: Text(
                      'No',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {},
                  )
                ],
              )
            ],
          );
        });
  }

  Future<void> _toLoginPageAndLogout() async {
    await Auth.logout();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text('Hello')],
          ),
        ),
      ),
    );
  }
}
