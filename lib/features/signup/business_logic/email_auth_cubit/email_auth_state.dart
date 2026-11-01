part of 'email_auth_cubit.dart';

@immutable
sealed class EmailAuthState {}

final class EmailAuthInitial extends EmailAuthState {}

final class EmailAuthSuccess extends EmailAuthState {
  final UserCredential userCredential;

  EmailAuthSuccess({required this.userCredential});
}

final class EmailAuthFailure extends EmailAuthState {
  final String errorMessage;

  EmailAuthFailure({required this.errorMessage});
}

final class EmailAuthLoading extends EmailAuthState {}
