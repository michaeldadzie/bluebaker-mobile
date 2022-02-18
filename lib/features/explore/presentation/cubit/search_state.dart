part of 'search_cubit.dart';

enum SearchStatus { initial, loading, loaded, error }

class SearchState extends Equatable {
  final List<Item> items;
  final SearchStatus status;
  final Failure failure;
  const SearchState({
    required this.items,
    required this.status,
    required this.failure,
  });

  factory SearchState.initial() {
    return const SearchState(
      items: [],
      status: SearchStatus.initial,
      failure: Failure(),
    );
  }

  @override
  List<Object?> get props => [items, status, failure];

  SearchState copyWith({
    List<Item>? items,
    SearchStatus? status,
    Failure? failure,
  }) {
    return SearchState(
      items: items ?? this.items,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
