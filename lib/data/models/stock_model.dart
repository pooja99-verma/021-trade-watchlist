import 'package:equatable/equatable.dart';

class Stock extends Equatable {
  final String id;
  final String symbol;
  final String exchange;
  final double price;
  final double absoluteChange;
  final double percentageChange;

  const Stock({
    required this.id,
    required this.symbol,
    required this.exchange,
    required this.price,
    required this.absoluteChange,
    required this.percentageChange,
  });

  bool get isPositive => absoluteChange > 0;
  bool get isNeutral => absoluteChange == 0;

  @override
  List<Object> get props => [id, symbol, exchange, price, absoluteChange, percentageChange];
}