import 'package:flutter/material.dart';
import 'resources/app.dart';
import 'package:mixtaprint_mobile_client/ui/splashscreen_page.dart';

void main()
{
  instantiateFirebaseApp();
  runApp(RootApp());
}

class RootApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}