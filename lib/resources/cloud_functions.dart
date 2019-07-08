import 'package:cloud_functions/cloud_functions.dart';

final fun = CloudFunctions.instance;

class HttpFunctions {
  // create storage and firestore document for new user
  static Future<bool> prepUserStorageAndDB(
      String uid, String inAppUsername) async {
    bool success = false;
    // preparing function call
    final HttpsCallable prep = fun.getHttpsCallable(
        functionName: 'prepUserStorageAndDB')
      ..timeout = Duration(seconds: 30);
    // call function
    await prep.call({
      'uid': uid,
      'inAppUsername': inAppUsername,
      'verified': false
    }).then((result) {
      // determine if the prepUserStorageAndDB functions not catching any error or problem
      success = result.data['success'];
      print('success inside prepUserStorageAndDB:' + success.toString());
    });
    return success;
  }
}
