import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// social media login
class SocialLogin {
  Function(String) errorCallback;
  Function(bool) progressIndicatorUpdateCallback;
  Function onLoginSuccess;

  SocialLogin(
      {this.errorCallback,
      this.progressIndicatorUpdateCallback,
      this.onLoginSuccess});

  /// facebook login instance
  final FacebookLogin facebookLogin = FacebookLogin();

  ///  fire base ui.auth object
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// google sign in object
  final GoogleSignIn googleSignIn = GoogleSignIn();

  /// manual email and password login
  Future<void> emailAndPasswordLogin({String email, String password}) async {
    progressIndicatorUpdateCallback(true);
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await user.user.getIdToken(true).then((data) {
        onLoginSuccess();
      });
    } on Exception catch (e) {
      progressIndicatorUpdateCallback(false);
      var errorMessage = '';
      if (e.toString().contains('ERROR_NETWORK_REQUEST_FAILED'))
        errorMessage = 'Please check your internet connection and try again';
      else if (e.toString().contains('ERROR_WRONG_PASSWORD'))
        errorMessage = 'Email Id or password is incorrect';
      else if (e.toString().contains('ERROR_USER_NOT_FOUND'))
        errorMessage = 'new user';
      else if (e.toString().toLowerCase().contains('user-not-found'))
        errorMessage = 'new user';
      else
        errorMessage = e.toString();
      errorCallback(errorMessage);
    }
  }

  /// on click of facebook login
  Future<void> facebook() async {
    final result = await facebookLogin.logIn(['email']);
    if (result != null) {
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          await loginWithFirebase(result);
          break;
        case FacebookLoginStatus.cancelledByUser:
          errorCallback('facebook login is canceled');
          break;
        case FacebookLoginStatus.error:
          errorCallback(result.errorMessage);
          break;
      }
    }
  }

  /// after login with social media logging with firebase
  Future<void> loginWithFirebase(FacebookLoginResult result) async {
    progressIndicatorUpdateCallback(true);
    try {
      final credential = FacebookAuthProvider.credential(
        result.accessToken.token,
      );
      final user = await _auth.signInWithCredential(credential);
      errorCallback('');
      await user.user.getIdToken(true).then((data) {
        onLoginSuccess();
      });
    } on Exception catch (e) {
      var errorMessage = '';
      await facebookLogin.logOut();
      progressIndicatorUpdateCallback(false);
      if (e
          .toString()
          .contains('ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL'))
        errorMessage =
            'An account already exists with the same email address but different sign-in credentials.';
      else
        errorMessage = e.toString();
      errorCallback(errorMessage);
    }
  }

  /// user registration with email, password and other fields
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    progressIndicatorUpdateCallback(true);
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      errorCallback('');
      await user.user.getIdToken(true).then((data) {
        onLoginSuccess();
      });
      return user.user.uid;
    } on Exception catch (e) {
      progressIndicatorUpdateCallback(false);
      var errorMessage = '';
      if (e
          .toString()
          .contains('ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL'))
        errorMessage =
            'An account already exists with the same email address but different sign-in credentials.';
      else if (e.toString().contains('ERROR_EMAIL_ALREADY_IN_USE'))
        errorMessage = 'new user';
      else
        errorMessage = e.toString();
      errorCallback(errorMessage);
    }
  }

  /// google sign in  method
  Future<void> signInWithGoogle() async {
    try {
      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        try {
          final googleSignInAuthentication =
              await googleSignInAccount.authentication;
          final credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );
          final authResult = await _auth.signInWithCredential(credential);
          progressIndicatorUpdateCallback(true);
          final user = authResult.user;
          assert(!user.isAnonymous, 'not anonymous');
          assert(await user.getIdToken(true) != null, ' id token is not null');
          final currentUser = await _auth.currentUser;
          assert(user.uid == currentUser.uid,
              'current user id is -- ${currentUser.uid}');
          await user.getIdToken(true).then((data) {
            onLoginSuccess();
          });
        } on Exception catch (error) {
          progressIndicatorUpdateCallback(false);
          errorCallback(error.toString());
        }
      }
    } on Exception catch (e) {
      var errorMessage = '';
      if (e.toString().contains('10'))
        errorMessage = 'Sign failed please check the development SHA key';
      else
        errorMessage = e.toString();
      progressIndicatorUpdateCallback(false);
      errorCallback(errorMessage);
    }
  }
}
