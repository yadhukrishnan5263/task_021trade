
import 'package:equatable/equatable.dart';

import '../models/stock.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object?> get props => [];
}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistLoaded extends WatchlistState {
  final List<Stock> stocks;
  final List<Stock> filteredStocks;
  final List<String> watchlists;
  final String selectedWatchlist;
  final String searchQuery;

  const WatchlistLoaded({
    required this.stocks,
    required this.filteredStocks,
    required this.watchlists,
    required this.selectedWatchlist,
    this.searchQuery = '',
  });

  WatchlistLoaded copyWith({
    List<Stock>? stocks,
    List<Stock>? filteredStocks,
    List<String>? watchlists,
    String? selectedWatchlist,
    String? searchQuery,
  }) {
    return WatchlistLoaded(
      stocks: stocks ?? this.stocks,
      filteredStocks: filteredStocks ?? this.filteredStocks,
      watchlists: watchlists ?? this.watchlists,
      selectedWatchlist: selectedWatchlist ?? this.selectedWatchlist,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [stocks, filteredStocks, watchlists, selectedWatchlist, searchQuery];
}

class WatchlistError extends WatchlistState {
  final String message;

  const WatchlistError({required this.message});

  @override
  List<Object?> get props => [message];
}

class WatchlistReordering extends WatchlistState {
  final List<Stock> stocks;
  final List<Stock> filteredStocks;
  final List<String> watchlists;
  final String selectedWatchlist;
  final String searchQuery;

  const WatchlistReordering({
    required this.stocks,
    required this.filteredStocks,
    required this.watchlists,
    required this.selectedWatchlist,
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [stocks, filteredStocks, watchlists, selectedWatchlist, searchQuery];
}
