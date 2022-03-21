part of 'anon_cubit.dart';

enum AnonStatus { initial, submitting, success, error }

class AnonState extends Equatable {
  final AnonStatus status;
  final Failure failure;
  const AnonState({
    required this.status,
    required this.failure,
  });

    factory AnonState.initial() {
    // ignore: prefer_const_constructors
    return AnonState(
      status: AnonStatus.initial,
      failure: const Failure(),
    );
  }

  @override
  List<Object> get props => [status, failure];

  AnonState copyWith({
    AnonStatus? status,
    Failure? failure,
  }) {
    return AnonState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
