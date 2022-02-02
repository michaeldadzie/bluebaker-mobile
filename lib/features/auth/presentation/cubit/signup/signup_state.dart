part of 'signup_cubit.dart';

enum SignupStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  final String name;
  final String email;
  final String password;
  final SignupStatus status;
  final Failure failure;
  final DateTime joined;

  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');

  bool get isFormValid =>
      name.isNotEmpty && email.isNotEmpty && password.isNotEmpty;

  const SignupState({
    required this.name,
    required this.email,
    required this.password,
    required this.status,
    required this.failure,
    required this.joined,
  });

  factory SignupState.initial() {
    return SignupState(
      name: '',
      email: '',
      password: '',
      joined: DateTime.parse(formatter.format(now)),
      status: SignupStatus.initial,
      failure: const Failure(),
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [name, email, password, status, failure, joined];

  SignupState copyWith({
    String? name,
    String? email,
    String? password,
    DateTime? joined,
    SignupStatus? status,
    Failure? failure,
  }) {
    return SignupState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      joined: joined ?? this.joined,
    );
  }
}
