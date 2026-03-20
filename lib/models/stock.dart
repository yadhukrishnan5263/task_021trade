import 'package:equatable/equatable.dart';

enum ExchangeType { nseEq, idx, nseMonthly }

class Stock extends Equatable {
  final String name;
  final ExchangeType exchange;
  final double price;
  final double change;
  final double changePercentage;
  final bool isPositive;

  const Stock({
    required this.name,
    required this.exchange,
    required this.price,
    required this.change,
    required this.changePercentage,
    required this.isPositive,
  });

  String get exchangeDisplay {
    switch (exchange) {
      case ExchangeType.nseEq:
        return 'NSE | EQ';
      case ExchangeType.idx:
        return 'IDX';
      case ExchangeType.nseMonthly:
        return 'NSE | Monthly';
    }
  }

  String get formattedPrice {
    if (price >= 100000) {
      return '${(price / 100000).toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{2})+$)'), (match) => '${match.group(1)},')},${(price % 100000).toStringAsFixed(2).padLeft(6, '0')}';
    } else if (price >= 1000) {
      return '${price.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,2})(?=(\d{2})+$)'), (match) => '${match.group(1)},')}';
    }
    return price.toStringAsFixed(2);
  }

  String get formattedChange {
    final sign = isPositive ? '+' : '';
    return '$sign${change.toStringAsFixed(2)} (${sign}${changePercentage.toStringAsFixed(2)}%)';
  }

  Stock copyWith({
    String? name,
    ExchangeType? exchange,
    double? price,
    double? change,
    double? changePercentage,
    bool? isPositive,
  }) {
    return Stock(
      name: name ?? this.name,
      exchange: exchange ?? this.exchange,
      price: price ?? this.price,
      change: change ?? this.change,
      changePercentage: changePercentage ?? this.changePercentage,
      isPositive: isPositive ?? this.isPositive,
    );
  }

  @override
  List<Object?> get props => [name, exchange, price, change, changePercentage, isPositive];

  @override
  String toString() {
    return 'Stock(name: $name, exchange: $exchangeDisplay, price: $formattedPrice, change: $formattedChange)';
  }
}
