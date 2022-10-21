import 'package:bluebaker/exports.dart';

part 'bluebaker_event.dart';
part 'bluebaker_state.dart';

class BlueBakerBloc extends Bloc<BlueBakerEvent, BlueBakerState> {
  final AuthBloc _authBloc;
  final BlueBakerRepository _blueBakerRepository;
  BlueBakerBloc({
    required AuthBloc authBloc,
    required BlueBakerRepository blueBakerRepository,
  })  : _authBloc = authBloc,
        _blueBakerRepository = blueBakerRepository,
        super(BlueBakerState.initial());

  @override
  Stream<BlueBakerState> mapEventToState(BlueBakerEvent event) async* {
    if (event is FetchItems) {
      yield* _mapFetchItemsToState();
    } else if (event is FetchCollections) {
      yield* _mapFetchCollectionsToState();
    } else if (event is FetchBlueBaker) {
      yield* _mapFetchBlueBakerToState();
    }
  }

  Stream<BlueBakerState> _mapFetchItemsToState() async* {
    yield state.copyWith(items: [], status: BlueBakerStatus.loading);
    try {
      final items = await _blueBakerRepository.fetchItems(
        userId: _authBloc.state.user!.uid,
      );
      yield state.copyWith(
        items: items,
        status: BlueBakerStatus.loaded,
      );
    } on Failure catch (error) {
      yield state.copyWith(
        status: BlueBakerStatus.error,
        failure: error,
      );
    }
  }

  Stream<BlueBakerState> _mapFetchCollectionsToState() async* {
    yield state.copyWith(collections: [], status: BlueBakerStatus.loading);
    try {
      final collections = await _blueBakerRepository.fetchCollections(
        userId: _authBloc.state.user!.uid,
      );
      yield state.copyWith(
        collections: collections,
        status: BlueBakerStatus.loaded,
      );
    } catch (error) {
      yield state.copyWith(
        status: BlueBakerStatus.error,
        failure: const Failure(
          message: 'We were unable to load',
        ),
      );
    }
  }

  Stream<BlueBakerState> _mapFetchBlueBakerToState() async* {
    yield state.copyWith(bluebaker: [], status: BlueBakerStatus.loading);
    try {
      final bluebaker = await _blueBakerRepository.fetchBlueBaker(
        userId: _authBloc.state.user!.uid,
      );
      yield state.copyWith(
        bluebaker: bluebaker,
        status: BlueBakerStatus.loaded,
      );
    } catch (error) {
      yield state.copyWith(
        status: BlueBakerStatus.error,
        failure: const Failure(
          message: 'We were unable to load',
        ),
      );
    }
  }
}
