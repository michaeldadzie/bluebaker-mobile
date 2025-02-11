import 'package:bluebaker/exports.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final BlueBakerRepository _blueBakerRepository;
  SearchCubit({required BlueBakerRepository blueBakerRepository})
      : _blueBakerRepository = blueBakerRepository,
        super(SearchState.initial());

  void searchBlueBaker(String query) async {
    emit(state.copyWith(status: SearchStatus.loading));
    try {
      final items = await _blueBakerRepository.searchBlueBaker(query: query);
      emit(
        state.copyWith(
          items: items,
          status: SearchStatus.loaded,
        ),
      );
    } catch (err) {
      state.copyWith(
        status: SearchStatus.error,
        failure: const Failure(
          message: 'Something went wrong. Please try again',
        ),
      );
    }
  }

  void clearSearch() {
    emit(state.copyWith(items: [], status: SearchStatus.initial));
  }
}
