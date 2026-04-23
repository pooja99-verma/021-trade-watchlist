import 'package:equatable/equatable.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlist extends WatchlistEvent {}

class ReorderWatchlist extends WatchlistEvent {
  final int oldIndex;
  final int newIndex;

  const ReorderWatchlist(this.oldIndex, this.newIndex);

  @override
  List<Object> get props => [oldIndex, newIndex];
}

class DeleteStock extends WatchlistEvent {
  final int index;

  const DeleteStock(this.index);

  @override
  List<Object> get props => [index];
}

class UpdatePricesTick extends WatchlistEvent {}