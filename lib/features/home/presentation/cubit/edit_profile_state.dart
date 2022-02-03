part of 'edit_profile_cubit.dart';

enum EditProfileStatus { initial, submmiting, succes, error }

class EditProfileState extends Equatable {
  final File? profileImage;
  final String username;
  final String name;
  final String country;
  final Timestamp? joined;
  final String telephone;
  final EditProfileStatus status;
  final Failure failure;

  const EditProfileState({
    required this.profileImage,
    required this.username,
    required this.name,
    required this.status,
    required this.country,
    required this.joined,
    required this.failure,
    required this.telephone,
  });

  factory EditProfileState.initial() {
    return const EditProfileState(
      profileImage: null,
      username: '',
      name: '',
      country: '',
      joined: null,
      telephone: '',
      status: EditProfileStatus.initial,
      failure: Failure(),
    );
  }

  @override
  List<Object?> get props => [
        profileImage,
        username,
        name,
        country,
        joined, telephone,
        status,
        failure
      ];

  EditProfileState copyWith({
    File? profileImage,
    String? username,
    String? name,
    String? country,
    Timestamp? joined,
    String? telephone,
    EditProfileStatus? status,
    Failure? failure,
  }) {
    return EditProfileState(
      profileImage: profileImage ?? this.profileImage,
      username: username ?? this.username,
      name: name ?? this.name,
      country: country ?? this.country,
      joined: joined ?? this.joined,
      telephone: telephone ?? this.telephone,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
