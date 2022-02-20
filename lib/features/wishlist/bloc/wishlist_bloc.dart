import 'package:bloc/bloc.dart';
import 'package:bluebaker/features/auth/data/models/failure.dart';
import 'package:bluebaker/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:bluebaker/features/bluebaker/data/repositories/bluebaker_repository.dart';
import 'package:bluebaker/features/bluebaker/data/models/item_model.dart';
import 'package:equatable/equatable.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final AuthBloc _authBloc;
  final BlueBakerRepository _blueBakerRepository;
  WishlistBloc({
    required AuthBloc authBloc,
    required BlueBakerRepository blueBakerRepository,
  })  : _authBloc = authBloc,
        _blueBakerRepository = blueBakerRepository,
        super(WishlistState.initial());
  @override
  Stream<WishlistState> mapEventToState(WishlistEvent event) async* {
    if (event is FetchWishlistItems) {
      yield* _mapFetchWishlistItemsToState(event);
    } else if (event is FetchWishlist) {
      yield* _mapFetchFetchWishlistToState();
    } else if (event is AddItemToWishlist) {
      yield* _mapAddItemToWishlistToState(event);
    } else if (event is RemoveItemFromWishlist) {
      yield* _mapRemoveItemFromWishlistToState(event);
    }
  }

  Stream<WishlistState> _mapFetchWishlistItemsToState(
      FetchWishlistItems event) async* {
    yield state.copyWith(items: [], status: WishlistStatus.loading);
    try {
      final items = await _blueBakerRepository.fetchWishlistItems(
          userId: _authBloc.state.user!.uid);
      final isFavoriteItem = await _blueBakerRepository.isFavoriteItem(
        userId: _authBloc.state.user!.uid,
        userWishedItemID: event.id,
      );
      yield state.copyWith(
        items: items,
        isFavoriteItem: isFavoriteItem,
        status: WishlistStatus.loaded,
      );
    } catch (error) {
      yield state.copyWith(
        status: WishlistStatus.error,
        failure: const Failure(
          message: 'We were unable to laod your wishlist',
        ),
      );
    }
  }

  Stream<WishlistState> _mapFetchFetchWishlistToState() async* {
    yield state.copyWith(items: [], status: WishlistStatus.loading);
    try {
      final items = await _blueBakerRepository.fetchWishlist(
        userId: _authBloc.state.user!.uid,
      );
      yield state.copyWith(
        items: items,
        status: WishlistStatus.loaded,
      );
    } catch (err) {
      yield state.copyWith(
        status: WishlistStatus.error,
        failure: const Failure(
            message: 'You don\'t have any items in your wishlist'),
      );
    }
  }

  Stream<WishlistState> _mapAddItemToWishlistToState(
      AddItemToWishlist event) async* {
    try {
      _blueBakerRepository.addItemToWishlist(
        userId: _authBloc.state.user!.uid,
        addItemID: event.id,
      );
      yield state.copyWith(isFavoriteItem: true);
    } catch (err) {
      yield state.copyWith(
        status: WishlistStatus.error,
        failure: const Failure(
          message: 'Something went wrong! Please try again',
        ),
      );
    }
  }

  Stream<WishlistState> _mapRemoveItemFromWishlistToState(
      RemoveItemFromWishlist event) async* {
    try {
      _blueBakerRepository.removeItemFromWishlist(
        userId: _authBloc.state.user!.uid,
        removeItemID: event.id,
      );
      yield state.copyWith(isFavoriteItem: false);
    } catch (err) {
      yield state.copyWith(
        status: WishlistStatus.error,
        failure: const Failure(
          message: 'Something went wrong! Please try again',
        ),
      );
    }
  }
}
