import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/failure.dart';
import '../../../data/repositories/auth_repository.dart';

part 'anon_state.dart';

class AnonCubit extends Cubit<AnonState> {
  final AuthRepository? _authRepository;
  AnonCubit({
    required AuthRepository? authRepository,
  })  : _authRepository = authRepository,
        super(AnonState?.initial());

  void logInAnonymously() async {
    if (state.status == AnonStatus.submitting) return;
    emit(state.copyWith(status: AnonStatus.submitting));
    try {
      await _authRepository?.logInAnonymously();
      emit(state.copyWith(status: AnonStatus.success));
    } on Failure catch (error) {
      emit(state.copyWith(failure: error, status: AnonStatus.error));
    }
  }
}
