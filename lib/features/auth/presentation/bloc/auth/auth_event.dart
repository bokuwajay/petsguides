abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventLogIn extends AuthEvent {
  final String email;
  final String password;
  const AuthEventLogIn({
    required this.email,
    required this.password,
  });
}

class AuthEventCheckSignInStatus extends AuthEvent {
  const AuthEventCheckSignInStatus();
}

class AuthEventFirstLaunch extends AuthEvent {
  const AuthEventFirstLaunch();
}

class AuthEventCheckFirstLaunch extends AuthEvent {
  const AuthEventCheckFirstLaunch();
}
