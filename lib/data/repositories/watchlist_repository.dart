import '../models/stock_model.dart';

class WatchlistRepository {
  Future<List<Stock>> fetchWatchlist() async {
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      const Stock(id: '1', symbol: 'RELIANCE', exchange: 'NSE | EQ', price: 1374.10, absoluteChange: -4.40, percentageChange: -0.32),
      const Stock(id: '2', symbol: 'HDFCBANK', exchange: 'NSE | EQ', price: 966.85, absoluteChange: 0.85, percentageChange: 0.09),
      const Stock(id: '3', symbol: 'ASIANPAINT', exchange: 'NSE | EQ', price: 2537.40, absoluteChange: 6.60, percentageChange: 0.26),
      const Stock(id: '4', symbol: 'NIFTY IT', exchange: 'IDX', price: 35187.30, absoluteChange: 876.86, percentageChange: 2.55),
      const Stock(id: '5', symbol: 'RELIANCE SEP 1880 CE', exchange: 'NSE | Monthly', price: 0.00, absoluteChange: 0.00, percentageChange: 0.00),
      const Stock(id: '6', symbol: 'RELIANCE SEP 1370 PE', exchange: 'NSE | Monthly', price: 19.20, absoluteChange: 1.00, percentageChange: 5.49),
      const Stock(id: '7', symbol: 'MRF', exchange: 'NSE | EQ', price: 147625.00, absoluteChange: 550.00, percentageChange: 0.37),
      const Stock(id: '8', symbol: 'MRF', exchange: 'BSE | EQ', price: 147439.45, absoluteChange: 463.80, percentageChange: 0.32),
    ];
  }
}