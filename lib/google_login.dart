import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io' show Platform;

class GoogleLogin {
  static final String? googleLoginIOSClientId = Platform.isIOS ? '201305529069-0bt8vkl844r71ungo9gfm2lksov7br9q.apps.googleusercontent.com' : null;

  static final _googleSignIn = GoogleSignIn(
    clientId: googleLoginIOSClientId,
  );
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
  static Future signOut = _googleSignIn.signOut();
}
