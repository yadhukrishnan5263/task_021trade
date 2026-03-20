import 'package:equatable/equatable.dart';
import '../models/stock.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object?> get props => [];
}

class LoadWatchlist extends WatchlistEvent {}

class ReorderStocks extends WatchlistEvent {
  final int oldIndex;
  final int newIndex;

  const ReorderStocks({required this.oldIndex, required this.newIndex});

  @override
  List<Object?> get props => [oldIndex, newIndex];
}

class AddStock extends WatchlistEvent {
  final Stock stock;

  const AddStock({required this.stock});

  @override
  List<Object?> get props => [stock];
}

class RemoveStock extends WatchlistEvent {
  final String stockName;

  const RemoveStock({required this.stockName});

  @override
  List<Object?> get props => [stockName];
}

class UpdateStockPrice extends WatchlistEvent {
  final String stockName;
  final double newPrice;
  final double change;
  final double changePercentage;
  final bool isPositive;

  const UpdateStockPrice({
    required this.stockName,
    required this.newPrice,
    required this.change,
    required this.changePercentage,
    required this.isPositive,
  });

  @override
  List<Object?> get props => [stockName, newPrice, change, changePercentage, isPositive];
}

class SearchStocks extends WatchlistEvent {
  final String query;

  const SearchStocks({required this.query});

  @override
  List<Object?> get props => [query];
}

class ClearSearch extends WatchlistEvent {}

class SelectWatchlist extends WatchlistEvent {
  final String watchlistName;

  const SelectWatchlist({required this.watchlistName});

  @override
  List<Object?> get props => [watchlistName];
}

class CreateWatchlist extends WatchlistEvent {
  final String name;

  const CreateWatchlist({required this.name});

  @override
  List<Object?> get props => [name];
}

class UpdateWatchlistName extends WatchlistEvent {
  final String oldName;
  final String newName;

  const UpdateWatchlistName({required this.oldName, required this.newName});

  @override
  List<Object?> get props => [oldName, newName];
}

class DeleteWatchlist extends WatchlistEvent {
  final String name;

  const DeleteWatchlist({required this.name});

  @override
  List<Object?> get props => [name];
}
