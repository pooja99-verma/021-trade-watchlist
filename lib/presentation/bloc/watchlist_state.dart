import 'package:equatable/equatable.dart';
import '../../data/models/stock_model.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistLoaded extends WatchlistState {
  final List<Stock> stocks;

  const WatchlistLoaded(this.stocks);

  @override
  List<Object> get props => [stocks];
}

class WatchlistError extends WatchlistState {
  final String message;

  const WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}