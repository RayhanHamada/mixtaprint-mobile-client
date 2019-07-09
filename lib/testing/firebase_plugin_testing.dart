import 'package:mixtaprint_mobile_client/resources/cloud_functions.dart';
import 'package:mixtaprint_mobile_client/resources/auth.dart';
import 'package:mixtaprint_mobile_client/resources/app.dart';
import 'package:mixtaprint_mobile_client/resources/db_firestore.dart';
import 'package:mixtaprint_mobile_client/resources/storage.dart';

Future<void> printAllPlugin() async {
  await App.app.options.then((value) {
    print('app');
    print(value.apiKey);
    print(value.googleAppID);
    print(value.projectID);
    print(value.storageBucket);
    print(value.databaseURL);
  });

  print('for firestore');
  await FirestoreDB.dbFirestore.app.options.then((value) {
    print('firestore');
    print(value.apiKey);
    print(value.googleAppID);
    print(value.projectID);
    print(value.storageBucket);
    print(value.databaseURL);
  });

  print('for auth');

  await Auth.auth.app.options.then((value) {
    print('app');
    print(value.apiKey);
    print(value.googleAppID);
    print(value.projectID);
    print(value.storageBucket);
    print(value.databaseURL);
  });
}