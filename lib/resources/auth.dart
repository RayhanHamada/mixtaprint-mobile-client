import 'package:firebase_auth/firebase_auth.dart';
import 'package:mixtaprint_mobile_client/resources/app.dart';
final auth = FirebaseAuth.fromApp(app);

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
      'status' : !catchError // if not catching any error, user can login
    };
  }

  static Future<void> logout() async
  {
    auth.signOut();
  }

  static Future<Map> signUp(String inAppUsername, String email, String password) async
  {

    bool catchError = false;
    String snackBarMsg = "";
    bool clear_password_field = false, clear_email_field = false;

    await auth.createUserWithEmailAndPassword(email: email, password: password)
        .catchError((error) {
          catchError = true;

          switch (error.code){
            case 'ERROR_WEAK_PASSWORD'  :
              snackBarMsg = 'Password is too weak, try another password';
              clear_password_field = true;
              break;
            case 'ERROR_INVALID_EMAIL' :
              snackBarMsg = 'Email address is invalid';
              clear_email_field = true;
              break;
            case 'ERROR_EMAIL_ALREADY_IN_USE' :
              snackBarMsg = 'Email already in use';
              clear_email_field = true;
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
      'status' : !catchError,
      'clr_email_field' : clear_email_field,
      'clr_pass_field' : clear_password_field
    };
  }

  static Future<void> prepUserStorageAndDB(String uid) async
  {

  }

}