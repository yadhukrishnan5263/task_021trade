import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/watchlist_bloc.dart';
import '../bloc/watchlist_event.dart';

class WatchlistTabs extends StatelessWidget {
  final List<String> watchlists;
  final String selectedWatchlist;

  const WatchlistTabs({
    super.key,
    required this.watchlists,
    required this.selectedWatchlist,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: watchlists.length,
        itemBuilder: (context, index) {
          final tab = watchlists[index];
          final isSelected = tab == selectedWatchlist;
          return GestureDetector(
            onTap: () => context.read<WatchlistBloc>().add(SelectWatchlist(watchlistName: tab)),
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? Colors.black : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                tab,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.grey[400],
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
