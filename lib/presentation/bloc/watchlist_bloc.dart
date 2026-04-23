import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/stock_model.dart';
import '../../data/repositories/watchlist_repository.dart';
import 'watchlist_event.dart';
import 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final WatchlistRepository repository;

  Timer? _priceTimer;
  final Random _random = Random();

  WatchlistBloc({required this.repository}) : super(WatchlistInitial()) {
    on<LoadWatchlist>(_onLoadWatchlist);
    on<ReorderWatchlist>(_onReorderWatchlist);
    on<DeleteStock>(_onDeleteStock);
    on<UpdatePricesTick>(_onUpdatePricesTick);
  }

  Future<void> _onLoadWatchlist(LoadWatchlist event, Emitter<WatchlistState> emit) async {
    emit(WatchlistLoading());

    try {
      final stocks = await repository.fetchWatchlist();
      emit(WatchlistLoaded(stocks));
      _priceTimer?.cancel();
      _priceTimer = Timer.periodic(const Duration(seconds: 2), (_) {
        add(UpdatePricesTick());
      });

    } catch (e) {
      emit(const WatchlistError('Failed to fetch market data. Please check your connection.'));
    }
  }

  void _onUpdatePricesTick(UpdatePricesTick event, Emitter<WatchlistState> emit) {
    if (state is WatchlistLoaded) {
      final currentState = state as WatchlistLoaded;

      final updatedStocks = currentState.stocks.map((stock) {
        if (stock.price == 0) return stock;

        double tick = (_random.nextDouble() * 3) - 1.5;

        double newPrice = stock.price + tick;
        double newAbsChange = stock.absoluteChange + tick;

        double basePrice = stock.price - stock.absoluteChange;
        double newPercChange = (newAbsChange / basePrice) * 100;

        return Stock(
          id: stock.id,
          symbol: stock.symbol,
          exchange: stock.exchange,
          price: newPrice,
          absoluteChange: newAbsChange,
          percentageChange: newPercChange,
        );
      }).toList();

      emit(WatchlistLoaded(updatedStocks));
    }
  }

  void _onReorderWatchlist(ReorderWatchlist event, Emitter<WatchlistState> emit) {
    if (state is WatchlistLoaded) {
      final currentState = state as WatchlistLoaded;
      final updatedList = List<Stock>.from(currentState.stocks);

      int oldIndex = event.oldIndex;
      int newIndex = event.newIndex;

      if (oldIndex < newIndex) {
        newIndex -= 1;
      }

      final item = updatedList.removeAt(oldIndex);
      updatedList.insert(newIndex, item);

      emit(WatchlistLoaded(updatedList));
    }
  }

  void _onDeleteStock(DeleteStock event, Emitter<WatchlistState> emit) {
    if (state is WatchlistLoaded) {
      final currentState = state as WatchlistLoaded;
      final updatedList = List<Stock>.from(currentState.stocks);
      updatedList.removeAt(event.index);

      emit(WatchlistLoaded(updatedList));
    }
  }

  @override
  Future<void> close() {
    _priceTimer?.cancel();
    return super.close();
  }
}