import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/stock.dart';
import '../models/watchlist_data.dart';
import 'watchlist_event.dart';
import 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final WatchlistData _watchlistData = WatchlistData();
  
  WatchlistBloc() : super(WatchlistInitial()) {
    on<LoadWatchlist>(_onLoadWatchlist);
    on<ReorderStocks>(_onReorderStocks);
    on<AddStock>(_onAddStock);
    on<RemoveStock>(_onRemoveStock);
    on<UpdateStockPrice>(_onUpdateStockPrice);
    on<SearchStocks>(_onSearchStocks);
    on<ClearSearch>(_onClearSearch);
    on<SelectWatchlist>(_onSelectWatchlist);
    on<CreateWatchlist>(_onCreateWatchlist);
    on<UpdateWatchlistName>(_onUpdateWatchlistName);
    on<DeleteWatchlist>(_onDeleteWatchlist);
  }

  void _onLoadWatchlist(LoadWatchlist event, Emitter<WatchlistState> emit) {
    emit(WatchlistLoading());

    _watchlistData.initialize();
    
    final watchlists = _watchlistData.getWatchlists();
    final selectedWatchlist = "Watchlist 1";
    final currentStocks = _watchlistData.getStocksForWatchlist(selectedWatchlist);

    emit(WatchlistLoaded(
      stocks: currentStocks,
      filteredStocks: currentStocks,
      watchlists: watchlists,
      selectedWatchlist: selectedWatchlist,
    ));
  }

  void _onReorderStocks(ReorderStocks event, Emitter<WatchlistState> emit) {
    if (state is WatchlistLoaded) {
      final currentState = state as WatchlistLoaded;
      final selectedWatchlist = currentState.selectedWatchlist;
      
      emit(WatchlistReordering(
        stocks: currentState.stocks,
        filteredStocks: currentState.filteredStocks,
        watchlists: currentState.watchlists,
        selectedWatchlist: currentState.selectedWatchlist,
        searchQuery: currentState.searchQuery,
      ));

      _watchlistData.reorderStocks(selectedWatchlist, event.oldIndex, event.newIndex);

      final reorderedStocks = _watchlistData.getStocksForWatchlist(selectedWatchlist);

      final reorderedFilteredStocks = List<Stock>.from(currentState.filteredStocks);
      if (currentState.searchQuery.isEmpty) {
        final filteredStock = reorderedFilteredStocks.removeAt(event.oldIndex);
        reorderedFilteredStocks.insert(event.newIndex, filteredStock);
      }

      emit(WatchlistLoaded(
        stocks: reorderedStocks,
        filteredStocks: reorderedFilteredStocks,
        watchlists: currentState.watchlists,
        selectedWatchlist: currentState.selectedWatchlist,
        searchQuery: currentState.searchQuery,
      ));
    }
  }

  void _onAddStock(AddStock event, Emitter<WatchlistState> emit) {
    if (state is WatchlistLoaded) {
      final currentState = state as WatchlistLoaded;
      final selectedWatchlist = currentState.selectedWatchlist;
      
      _watchlistData.addStockToWatchlist(selectedWatchlist, event.stock);
      
      final updatedStocks = _watchlistData.getStocksForWatchlist(selectedWatchlist);
      
      emit(WatchlistLoaded(
        stocks: updatedStocks,
        filteredStocks: updatedStocks,
        watchlists: currentState.watchlists,
        selectedWatchlist: currentState.selectedWatchlist,
        searchQuery: currentState.searchQuery,
      ));
    }
  }

  void _onRemoveStock(RemoveStock event, Emitter<WatchlistState> emit) {
    if (state is WatchlistLoaded) {
      final currentState = state as WatchlistLoaded;
      final selectedWatchlist = currentState.selectedWatchlist;
      
      _watchlistData.removeStockFromWatchlist(selectedWatchlist, event.stockName);
      
      final updatedStocks = _watchlistData.getStocksForWatchlist(selectedWatchlist);
      
      emit(WatchlistLoaded(
        stocks: updatedStocks,
        filteredStocks: updatedStocks,
        watchlists: currentState.watchlists,
        selectedWatchlist: currentState.selectedWatchlist,
        searchQuery: currentState.searchQuery,
      ));
    }
  }

  void _onUpdateStockPrice(UpdateStockPrice event, Emitter<WatchlistState> emit) {
    if (state is WatchlistLoaded) {
      final currentState = state as WatchlistLoaded;
      final selectedWatchlist = currentState.selectedWatchlist;
      
      final stocks = _watchlistData.getStocksForWatchlist(selectedWatchlist);
      final updatedStocks = stocks.map((stock) {
        if (stock.name == event.stockName) {
          return Stock(
            name: stock.name,
            exchange: stock.exchange,
            price: event.newPrice,
            change: stock.change,
            changePercentage: stock.changePercentage,
            isPositive: stock.isPositive,
          );
        }
        return stock;
      }).toList();

      _watchlistData.addWatchlist(selectedWatchlist, updatedStocks);
      
      emit(WatchlistLoaded(
        stocks: updatedStocks,
        filteredStocks: updatedStocks,
        watchlists: currentState.watchlists,
        selectedWatchlist: currentState.selectedWatchlist,
        searchQuery: currentState.searchQuery,
      ));
    }
  }

  void _onSearchStocks(SearchStocks event, Emitter<WatchlistState> emit) {
    if (state is WatchlistLoaded) {
      final currentState = state as WatchlistLoaded;
      final filteredStocks = currentState.stocks.where((stock) {
        return stock.name.toLowerCase().contains(event.query.toLowerCase());
      }).toList();

      emit(WatchlistLoaded(
        stocks: currentState.stocks,
        filteredStocks: filteredStocks,
        watchlists: currentState.watchlists,
        selectedWatchlist: currentState.selectedWatchlist,
        searchQuery: event.query,
      ));
    }
  }

  void _onClearSearch(ClearSearch event, Emitter<WatchlistState> emit) {
    if (state is WatchlistLoaded) {
      final currentState = state as WatchlistLoaded;
      
      emit(WatchlistLoaded(
        stocks: currentState.stocks,
        filteredStocks: currentState.stocks,
        watchlists: currentState.watchlists,
        selectedWatchlist: currentState.selectedWatchlist,
        searchQuery: '',
      ));
    }
  }

  void _onSelectWatchlist(SelectWatchlist event, Emitter<WatchlistState> emit) {
    if (state is WatchlistLoaded) {
      final currentState = state as WatchlistLoaded;
      final selectedWatchlist = event.watchlistName;
      final currentStocks = _watchlistData.getStocksForWatchlist(selectedWatchlist);
      
      emit(WatchlistLoaded(
        stocks: currentStocks,
        filteredStocks: currentStocks,
        watchlists: currentState.watchlists,
        selectedWatchlist: selectedWatchlist,
        searchQuery: '',
      ));
    }
  }

  void _onCreateWatchlist(CreateWatchlist event, Emitter<WatchlistState> emit) {
    if (state is WatchlistLoaded) {
      final currentState = state as WatchlistLoaded;
      
      _watchlistData.addWatchlist(event.name, []);
      
      final updatedWatchlists = _watchlistData.getWatchlists();
      
      emit(WatchlistLoaded(
        stocks: currentState.stocks,
        filteredStocks: currentState.filteredStocks,
        watchlists: updatedWatchlists,
        selectedWatchlist: currentState.selectedWatchlist,
        searchQuery: currentState.searchQuery,
      ));
    }
  }

  void _onUpdateWatchlistName(UpdateWatchlistName event, Emitter<WatchlistState> emit) {
    if (state is WatchlistLoaded) {
      final currentState = state as WatchlistLoaded;
      
      _watchlistData.updateWatchlist(event.oldName, event.newName);
      
      final updatedWatchlists = _watchlistData.getWatchlists();
      final newSelectedWatchlist = event.newName;
      final currentStocks = _watchlistData.getStocksForWatchlist(newSelectedWatchlist);
      
      emit(WatchlistLoaded(
        stocks: currentStocks,
        filteredStocks: currentStocks,
        watchlists: updatedWatchlists,
        selectedWatchlist: newSelectedWatchlist,
        searchQuery: currentState.searchQuery,
      ));
    }
  }

  void _onDeleteWatchlist(DeleteWatchlist event, Emitter<WatchlistState> emit) {
    if (state is WatchlistLoaded) {
      final currentState = state as WatchlistLoaded;
      
      _watchlistData.removeWatchlist(event.name);
      
      final updatedWatchlists = _watchlistData.getWatchlists();
      final newSelectedWatchlist = updatedWatchlists.isNotEmpty ? updatedWatchlists.first : '';
      final currentStocks = _watchlistData.getStocksForWatchlist(newSelectedWatchlist);
      
      emit(WatchlistLoaded(
        stocks: currentStocks,
        filteredStocks: currentStocks,
        watchlists: updatedWatchlists,
        selectedWatchlist: newSelectedWatchlist,
        searchQuery: currentState.searchQuery,
      ));
    }
  }
}
