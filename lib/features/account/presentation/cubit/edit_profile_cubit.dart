import 'dart:io';
import 'package:bluebaker/exports.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UserRepository _userRepository;
  final StorageRepository _storageRepository;
  final ProfileBloc _profileBloc;
  EditProfileCubit({
    required UserRepository userRepository,
    required StorageRepository storageRepository,
    required ProfileBloc profileBloc,
  })  : _userRepository = userRepository,
        _storageRepository = storageRepository,
        _profileBloc = profileBloc,
        super(EditProfileState.initial()) {
    final user = _profileBloc.state.user;
    emit(state.copyWith(username: user.username));
  }

  void profileImageChanged(File? image) {
    emit(
      state.copyWith(
        profileImage: image,
        status: EditProfileStatus.initial,
      ),
    );
  }

  void nameChanged(String? name) {
    emit(
      state.copyWith(
        name: name,
        status: EditProfileStatus.initial,
      ),
    );
  }

  void usernameChanged(String? username) {
    emit(
      state.copyWith(
        username: username,
        status: EditProfileStatus.initial,
      ),
    );
  }

  void countryChanged(String? country) {
    emit(
      state.copyWith(
        country: country,
        status: EditProfileStatus.initial,
      ),
    );
  }

  void telephoneChanged(String? telephone) {
    emit(
      state.copyWith(
        telephone: telephone,
        status: EditProfileStatus.initial,
      ),
    );
  }

  void submit() async {
    emit(state.copyWith(status: EditProfileStatus.submmiting));
    try {
      final user = _profileBloc.state.user;
      var profileImageUrl = user.profileImageUrl;
      if (state.profileImage != null) {
        profileImageUrl = await _storageRepository.uploadProfileImage(
          url: profileImageUrl,
          image: state.profileImage!,
        );
      }

      final updatedUser = user.copyWith(
        profileImageUrl: profileImageUrl,
        name: state.name,
        username: state.username,
        country: state.country,
        telephone: state.telephone,
      );

      await _userRepository.updateUser(user: updatedUser);
      _profileBloc.add(ProfileLoadUser(userId: user.id));
      emit(state.copyWith(status: EditProfileStatus.succes));
    } catch (err) {
      emit(
        state.copyWith(
          status: EditProfileStatus.error,
          failure: const Failure(
            message: 'We were unable to update your profile',
          ),
        ),
      );
    }
  }
}
