import 'package:firebase_auth/firebase_auth.dart';
import 'package:mixtaprint_mobile_client/resources/app.dart';
FirebaseAuth auth = FirebaseAuth.fromApp(app);


class Auth
{
  static Future<Map> login(String email, String password) async
  {
    bool catchError = false;
    String snackBarMsg = "";
    await auth.signInWithEmailAndPassword(email: email, password: password)
        .catchError((error) {
            catchError = true;

            switch (error.code){
              case 'ERROR_INVALID_EMAIL'  :
                snackBarMsg = 'invalid email, please use other email !';
                break;
              case 'ERROR_WRONG_PASSWORD' :
                snackBarMsg = 'invalid password';
                break;
              case 'ERROR_USER_NOT_FOUND' :
                snackBarMsg = 'User is not found :(';
                break;
              case 'ERROR_USER_DISABLED'  :
                snackBarMsg = 'User is disabled';
                break;
            }
          })
        .then((user) {
          // do something when user is on
          if (!catchError){
            snackBarMsg = "Login successful, please wait...";

          }
        });
    return {
      'msg' : snackBarMsg,
      'status' : !catchError
    };
  }

  static Future<void> logout() async
  {
    auth.signOut();
  }

}