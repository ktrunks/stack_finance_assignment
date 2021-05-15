import 'package:firebase_auth/firebase_auth.dart';
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
          onLoginSuccess();
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
