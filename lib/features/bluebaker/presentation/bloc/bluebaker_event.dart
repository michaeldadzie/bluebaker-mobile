part of 'bluebaker_bloc.dart';

abstract class BlueBakerEvent extends Equatable {
  const BlueBakerEvent();

  @override
  List<Object?> get props => [];
}

class FetchItems extends BlueBakerEvent {}

class FetchCollections extends BlueBakerEvent {}

class FetchBlueBaker extends BlueBakerEvent {}
