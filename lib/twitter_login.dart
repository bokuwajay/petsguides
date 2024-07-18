import 'package:twitter_login/twitter_login.dart';

class XLogin {
  static const twitterApiKey = 'vLP9Vo6rfIiMVP4fEQMl91qFl';
  static const twitterApiSecretKey = 'VjzMNg2qg5Mj2ilVFvKeO3ao5JE0KX0QETvZrG4Ac0GSL726MM';

  static Future twitterLogin() async {
    final twitterLogin = TwitterLogin(
      /// Consumer API keys
      apiKey: twitterApiKey,

      /// Consumer API Secret keys
      apiSecretKey: twitterApiSecretKey,

      /// Registered Callback URLs in TwitterApp
      /// Android is a deeplink
      /// iOS is a URLScheme
      redirectURI: 'petsguides://',
    );

    /// Forces the user to enter their credentials
    /// to ensure the correct users account is authorized.
    /// If you want to implement Twitter account switching, set [force_login] to true
    /// login(forceLogin: true);
    final authResult = await twitterLogin.login();
    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        // success
        print('====== Login success ======');
        print(authResult.authToken);
        print(authResult.authTokenSecret);
        break;
      case TwitterLoginStatus.cancelledByUser:
        // cancel
        print('====== Login cancel ======');
        break;
      case TwitterLoginStatus.error:
      case null:
        // error
        print('====== Login error ======');
        break;
    }
  }
}
