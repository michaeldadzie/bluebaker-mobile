import 'package:bluebaker/exports.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;
  SignupCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(SignupState?.initial());

  void nameChanged(String? value) {
    emit(state.copyWith(name: value, status: SignupStatus.initial));
  }

  void emailChanged(String? value) {
    emit(state.copyWith(email: value, status: SignupStatus.initial));
  }

  void passwordChanged(String? value) {
    emit(state.copyWith(password: value, status: SignupStatus.initial));
  }

  void signUpWithCredentials() async {
    if (!state.isFormValid || state.status == SignupStatus.submitting) return;
    emit(state.copyWith(status: SignupStatus.submitting));
    try {
      await _authRepository.signUpWithEmailAndPassword(
          name: state.name,
          email: state.email,
          password: state.password,
          joined: state.joined);
      emit(state.copyWith(status: SignupStatus.success));
    } on Failure catch (error) {
      emit(state.copyWith(failure: error, status: SignupStatus.error));
    }
  }
}
