import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uber/features/signup/business_logic/repositories/google_auth_repository.dart';
import 'package:uber/features/signup/data/models/user_model.dart';

part 'google_auth_state.dart';

class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  GoogleAuthRepository googleAuthRepository;

  GoogleAuthCubit({required this.googleAuthRepository})
    : super(GoogleAuthInitial());

  Future<void> signInWithGoogle() async {
    emit(GoogleAuthLoading());
    try {
      final userModel = await googleAuthRepository.signInWithGoogle();
      if (userModel != null) {
        emit(GoogleAuthSuccess(userModel: userModel));
      } else {
        emit(GoogleAuthFailure(errorMessage: 'Failed to sign in with Google'));
      }
    } catch (e) {
      emit(GoogleAuthFailure(errorMessage: e.toString()));
    }
  }
}
