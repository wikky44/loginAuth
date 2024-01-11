abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final Map<String, dynamic> userData;

  AuthSuccess(this.userData);
}

class AuthError extends AuthState {
  final String errorMessage;

  AuthError(this.errorMessage);
}
