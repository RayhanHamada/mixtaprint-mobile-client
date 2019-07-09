import 'package:flutter/material.dart';
import 'package:mixtaprint_mobile_client/resources/auth.dart';
import 'package:mixtaprint_mobile_client/ui/login_page.dart';
import 'package:mixtaprint_mobile_client/ui/signup_page.dart';
import 'package:mixtaprint_mobile_client/ui/splashscreen_page.dart';

import 'ui/home_page.dart';

bool _authUserExist;
void main() async {
  _authUserExist = ((await Auth.auth.currentUser()) != null);
  runApp(RootApp());
}

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _authUserExist ? HomePage() : SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        LoginPage.routeName: (context) => LoginPage(),
        SignUpPage.routeName: (context) => SignUpPage(),
        HomePage.routeName: (context) => HomePage()
      },
    );
  }
}
