import 'package:firebase_auth/firebase_auth.dart';
import 'package:mixtaprint_mobile_client/resources/app.dart';
import 'package:mixtaprint_mobile_client/resources/cloud_functions.dart';

class Auth {
  static final auth = FirebaseAuth.fromApp(app);

  static Future<Map> login(String email, String password) async {
    bool catchError = false;
    String snackBarMsg = "";
    await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((error) {
      catchError = true;

      switch (error.code) {
        case 'ERROR_INVALID_EMAIL':
          snackBarMsg = 'invalid email, please use other email !';
          break;
        case 'ERROR_WRONG_PASSWORD':
          snackBarMsg = 'invalid password';
          break;
        case 'ERROR_USER_NOT_FOUND':
          snackBarMsg = 'User is not found :(';
          break;
        case 'ERROR_USER_DISABLED':
          snackBarMsg = 'User is disabled';
          break;
      }
    }).then((user) {
      // do something when user is on
      if (!catchError) {
        snackBarMsg = "Login successful, please wait...";
      }
    });
    return {
      'msg': snackBarMsg,
      'status': !catchError // if not catching any error, user can login
    };
  }

  static Future<void> logout() async {
    auth.signOut();
  }

  static Future<Map> signUp(
      String inAppUsername, String email, String password) async {
    bool catchError = false;
    String snackBarMsg = "";
    bool clearPasswordField = false, clearEmailField = false;

    await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((error) {
      catchError = true;

      switch (error.code) {
        case 'ERROR_WEAK_PASSWORD':
          snackBarMsg = 'Password is too weak, try another password';
          clearPasswordField = true;
          break;
        case 'ERROR_INVALID_EMAIL':
          snackBarMsg = 'Email address is invalid';
          clearEmailField = true;
          break;
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          snackBarMsg = 'Email already in use';
          clearEmailField = true;
          break;
      }
    }).then((user) async {
      // do something when user is on
      if (!catchError) {
        // check if the request we send is fine, if not then we would change snackBarMsg and status
        await HttpFunctions.prepUserStorageAndDB(user.uid, inAppUsername)
            .then((success) {
          if (!success) {
            catchError = true;
            snackBarMsg = 'There\'s a problem when requesting to the server...';
          } else {
            snackBarMsg = "Sign up successful, please wait...";
          }
        });
      }
    });

    return {
      'msg': snackBarMsg,
      'status': !catchError,
      'clr_email_field': clearEmailField,
      'clr_pass_field': clearPasswordField
    };
  }
}
