import 'package:flutter/material.dart';
import 'package:mixtaprint_mobile_client/resources/auth.dart';
import 'package:mixtaprint_mobile_client/ui/splashscreen_page.dart';

import 'ui/home_page.dart';

bool _authUserExist;
void main() async
{
  _authUserExist = ((await Auth.auth.currentUser()) == null);
  runApp(RootApp());
}

class RootApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _authUserExist ? HomePage() : SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}