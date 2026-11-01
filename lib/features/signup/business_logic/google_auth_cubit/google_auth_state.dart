part of 'google_auth_cubit.dart';

@immutable
sealed class GoogleAuthState {}

final class GoogleAuthInitial extends GoogleAuthState {}

final class GoogleAuthSuccess extends GoogleAuthState {
  final UserModel userModel;
  GoogleAuthSuccess({required this.userModel});
}

final class GoogleAuthFailure extends GoogleAuthState {
  final String errorMessage;
  GoogleAuthFailure({required this.errorMessage});
}

final class GoogleAuthLoading extends GoogleAuthState {}
