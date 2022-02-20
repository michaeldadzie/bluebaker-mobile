part of 'wishlist_bloc.dart';

enum WishlistStatus { initial, loading, loaded, error, add, remove }

class WishlistState extends Equatable {
  final List<Item> items;
  final bool isFavoriteItem;
  final WishlistStatus status;
  final Failure failure;
  const WishlistState({
    required this.items,
    required this.isFavoriteItem,
    required this.status,
    required this.failure,
  });

  factory WishlistState.initial() {
    return const WishlistState(
      items: [],
      isFavoriteItem: false,
      status: WishlistStatus.initial,
      failure: Failure(),
    );
  }

  @override
  List<Object?> get props => [items, isFavoriteItem, status, failure];

  WishlistState copyWith({
    List<Item>? items,
    bool? isFavoriteItem,
    WishlistStatus? status,
    Failure? failure,
  }) {
    return WishlistState(
      items: items ?? this.items,
      isFavoriteItem: isFavoriteItem ?? this.isFavoriteItem,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
