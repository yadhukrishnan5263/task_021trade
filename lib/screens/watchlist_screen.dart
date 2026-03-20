import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/watchlist_bloc.dart';
import '../bloc/watchlist_state.dart';
import '../widgets/index_tile.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/watchlist_tabs.dart';
import '../widgets/sort_header.dart';
import '../widgets/stock_list.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/empty_state_widget.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _WatchlistView();
  }
}

class _WatchlistView extends StatefulWidget {
  const _WatchlistView();

  @override
  State<_WatchlistView> createState() => _WatchlistViewState();
}

class _WatchlistViewState extends State<_WatchlistView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0.5,
        toolbarHeight: 70,

        title: BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IndexTile(
                  title: "SENSEX 18TH SEP 8...",
                  price: "1,225.55",
                  change: "144.50 (13.3...",
                  isPositive: true,
                ),
                SizedBox(width: 8,),
                Container(width: 1, height: 45, color: Colors.grey),
                SizedBox(width: 8,),
                const IndexTile(
                  title: "NIFTY BANK",
                  price: "54,172.85",
                  change: "-14.05 (-0.03...",
                  isPositive: false,
                ),
                const Icon(Icons.chevron_right, color: Colors.black, size: 20),
              ],
            );
          },
        ),
      ),
      body: BlocBuilder<WatchlistBloc, WatchlistState>(
        builder: (context, state) {
          if (state is WatchlistLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is WatchlistLoaded || state is WatchlistReordering) {
            final stocks = state is WatchlistLoaded
                ? state.filteredStocks
                : (state as WatchlistReordering).filteredStocks;
            final watchlists = state is WatchlistLoaded
                ? state.watchlists
                : (state as WatchlistReordering).watchlists;
            final selectedWatchlist = state is WatchlistLoaded
                ? state.selectedWatchlist
                : (state as WatchlistReordering).selectedWatchlist;

            return Column(
              children: [
                const SearchBarWidget(),
                WatchlistTabs(watchlists: watchlists, selectedWatchlist: selectedWatchlist),
                const Divider(height: 1, thickness: 0.5),
                const SortHeader(),
                Expanded(
                  child: stocks.isEmpty
                      ? EmptyStateWidget(state: state)
                      : StockList(stocks: stocks),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}