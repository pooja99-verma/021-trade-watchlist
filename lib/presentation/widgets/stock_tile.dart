import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../data/models/stock_model.dart';
import '../bloc/watchlist_bloc.dart';
import '../screens/edit_watchlist_screen.dart';

class StockTile extends StatelessWidget {
  final Stock stock;

  const StockTile({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat("#,##0.00", "en_IN");

    Color changeColor = stock.isNeutral
        ? Colors.grey.shade400
        : (stock.isPositive ? Colors.green.shade600 : Colors.red.shade400);

    return InkWell(
      onLongPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: BlocProvider.of<WatchlistBloc>(context),
              child: const EditWatchlistScreen(),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(stock.symbol, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black87)),
                const SizedBox(height: 4),
                Text(stock.exchange, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  currencyFormat.format(stock.price),
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: changeColor),
                ),
                const SizedBox(height: 4),
                Text(
                  '${stock.absoluteChange > 0 ? '' : ''}${currencyFormat.format(stock.absoluteChange)} (${stock.percentageChange.toStringAsFixed(2)}%)',
                  style: TextStyle(color: changeColor, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}