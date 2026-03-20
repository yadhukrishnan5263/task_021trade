import '../models/stock.dart';

class WatchlistData {
  static final WatchlistData _instance = WatchlistData._internal();
  factory WatchlistData() => _instance;
  WatchlistData._internal();

  late List<Stock> _baseStocks;
  final Map<String, List<Stock>> _watchlistData = {};

  void initialize() {
    _baseStocks = [
      Stock(
        name: "RELIANCE",
        exchange: ExchangeType.nseEq,
        price: 1374.00,
        change: -4.50,
        changePercentage: -0.33,
        isPositive: false,
      ),
      Stock(
        name: "HDFCBANK",
        exchange: ExchangeType.nseEq,
        price: 966.85,
        change: 0.85,
        changePercentage: 0.09,
        isPositive: true,
      ),
      Stock(
        name: "ASIANPAINT",
        exchange: ExchangeType.nseEq,
        price: 2537.40,
        change: 6.60,
        changePercentage: 0.26,
        isPositive: true,
      ),
      Stock(
        name: "NIFTY IT",
        exchange: ExchangeType.idx,
        price: 35187.55,
        change: 877.11,
        changePercentage: 2.56,
        isPositive: true,
      ),
      Stock(
        name: "RELIANCE SEP 1880 CE",
        exchange: ExchangeType.nseMonthly,
        price: 0.00,
        change: 0.00,
        changePercentage: 0.00,
        isPositive: true,
      ),
      Stock(
        name: "RELIANCE SEP 1370 PE",
        exchange: ExchangeType.nseMonthly,
        price: 19.20,
        change: 1.00,
        changePercentage: 5.49,
        isPositive: true,
      ),
      Stock(
        name: "MRF",
        exchange: ExchangeType.nseEq,
        price: 147625.00,
        change: 550.00,
        changePercentage: 0.37,
        isPositive: true,
      ),
    ];

    _watchlistData["Watchlist 1"] = List.from(_baseStocks);

    _watchlistData["Watchlist 2"] = [
      _baseStocks[3],
      _baseStocks[4],
      _baseStocks[5],
      _baseStocks[0],
      _baseStocks[1],
      _baseStocks[2],
      _baseStocks[6],
    ];
    

    _watchlistData["Watchlist 3"] = [
      _baseStocks[6],
      _baseStocks[0],
      _baseStocks[3],
      _baseStocks[1],
      _baseStocks[2],
      _baseStocks[4],
      _baseStocks[5],
    ];
  }

  List<String> getWatchlists() {
    return _watchlistData.keys.toList();
  }

  List<Stock> getStocksForWatchlist(String watchlistName) {
    return _watchlistData[watchlistName] ?? [];
  }

  void addWatchlist(String name, List<Stock> stocks) {
    _watchlistData[name] = stocks;
  }

  void updateWatchlist(String oldName, String newName) {
    if (_watchlistData.containsKey(oldName)) {
      _watchlistData[newName] = _watchlistData[oldName]!;
      _watchlistData.remove(oldName);
    }
  }

  void removeWatchlist(String name) {
    _watchlistData.remove(name);
  }

  void reorderStocks(String watchlistName, int oldIndex, int newIndex) {
    final stocks = _watchlistData[watchlistName];
    if (stocks != null) {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final stock = stocks.removeAt(oldIndex);
      stocks.insert(newIndex, stock);
    }
  }

  void addStockToWatchlist(String watchlistName, Stock stock) {
    if (_watchlistData.containsKey(watchlistName)) {
      _watchlistData[watchlistName]!.add(stock);
    }
  }

  void removeStockFromWatchlist(String watchlistName, String stockName) {
    if (_watchlistData.containsKey(watchlistName)) {
      _watchlistData[watchlistName]!.removeWhere((stock) => stock.name == stockName);
    }
  }
}
