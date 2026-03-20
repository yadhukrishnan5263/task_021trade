import 'package:flutter/material.dart';
import '../bloc/watchlist_state.dart';
import 'empty_state.dart';

class EmptyStateWidget extends StatelessWidget {
  final WatchlistState state;

  const EmptyStateWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return const EmptyState(
      title: 'No stocks in watchlist',
      subtitle: 'Add stocks to get started',
      icon: Icons.list_alt,
    );
  }
}
