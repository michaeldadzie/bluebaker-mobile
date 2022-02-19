part of 'bluebaker_bloc.dart';

enum BlueBakerStatus { initial, loading, loaded, error }

class BlueBakerState extends Equatable {
  final List<Item> items;
  final List<Collection> collections;
  final List<BlueBaker> bluebaker;
  final BlueBakerStatus status;
  final Failure failure;
  const BlueBakerState({
    required this.items,
    required this.collections,
    required this.bluebaker,
    required this.status,
    required this.failure,
  });

  factory BlueBakerState.initial() {
    return const BlueBakerState(
      items: [],
      collections: [],
      bluebaker: [],
      status: BlueBakerStatus.initial,
      failure: Failure(),
    );
  }

  @override
  List<Object?> get props => [items, collections, bluebaker, status, failure];

  BlueBakerState copyWith({
    List<Item>? items,
    List<Collection>? collections,
    List<BlueBaker>? bluebaker,
    BlueBakerStatus? status,
    Failure? failure,
  }) {
    return BlueBakerState(
      items: items ?? this.items,
      collections: collections ?? this.collections,
      bluebaker: bluebaker ?? this.bluebaker,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
