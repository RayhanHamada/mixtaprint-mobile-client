import 'package:firebase_core/firebase_core.dart';
// this module is optional, since we already specify the Firebase Options in the google-services.json

// create options for instantiate a firebase app
FirebaseOptions _options = FirebaseOptions(
  googleAppID: '1:112889401086:android:afe663e7ea80a75f',
  storageBucket: 'mixtaprint-bdece.appspot.com',
  projectID: 'mixtaprint-bdece',
  apiKey: 'AIzaSyDp2BUTKiHp4Xrds04-yScQa9ix6uLxRrw',
);

FirebaseApp app;

Future<void> instantiateFirebaseApp() async {
  // optionally, this configure method is not necessary, since the plugin we're using will automatically configure it
  app = await FirebaseApp.configure(name: 'Mixtaprint', options: _options);
}
