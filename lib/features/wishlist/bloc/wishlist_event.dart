part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object?> get props => [];
}

class FetchWishlistItems extends WishlistEvent {
  final String id;

  const FetchWishlistItems({required this.id});

  @override
  List<Object?> get props => [id];
}

class FetchWishlist extends WishlistEvent {}

class AddItemToWishlist extends WishlistEvent {
  final String id;

  const AddItemToWishlist({required this.id});

  @override
  List<Object?> get props => [id];
}

class RemoveItemFromWishlist extends WishlistEvent {
  final String id;

  const RemoveItemFromWishlist({required this.id});

  @override
  List<Object?> get props => [id];
}

