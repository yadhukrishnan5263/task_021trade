import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/watchlist_bloc.dart';
import '../bloc/watchlist_event.dart';
import '../bloc/watchlist_state.dart';
import '../widgets/empty_state.dart';
import '../widgets/watchlist_name_field.dart';
import '../widgets/reorderable_stock_list.dart';
import '../widgets/edit_watchlist_bottom_buttons.dart';

class EditWatchlistScreen extends StatelessWidget {
  const EditWatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _EditWatchlistView();
  }
}

class _EditWatchlistView extends StatefulWidget {
  const _EditWatchlistView();

  @override
  State<_EditWatchlistView> createState() => _EditWatchlistViewState();
}

class _EditWatchlistViewState extends State<_EditWatchlistView> {
  final TextEditingController _watchlistNameController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _submitNameChange();
      }
    });
  }

  @override
  void dispose() {
    _watchlistNameController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submitNameChange() {
    final state = context.read<WatchlistBloc>().state;
    if (_watchlistNameController.text.isNotEmpty) {
      final oldName = state is WatchlistLoaded
          ? state.selectedWatchlist
          : (state is WatchlistReordering ? state.selectedWatchlist : '');

      if (oldName.isNotEmpty && oldName != _watchlistNameController.text) {
        context.read<WatchlistBloc>().add(
          UpdateWatchlistName(
            oldName: oldName,
            newName: _watchlistNameController.text,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {
            String title = "Edit Watchlist";
            if (state is WatchlistLoaded) {
              title = "Edit ${state.selectedWatchlist}";
            } else if (state is WatchlistReordering) {
              title = "Edit ${state.selectedWatchlist}";
            }
            return Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: BlocBuilder<WatchlistBloc, WatchlistState>(
        builder: (context, state) {
          if (state is WatchlistLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is WatchlistError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading watchlist',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<WatchlistBloc>().add(LoadWatchlist()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is WatchlistLoaded || state is WatchlistReordering) {
            final stocks = state is WatchlistLoaded
                ? state.stocks
                : (state as WatchlistReordering).stocks;
            final selectedWatchlist = state is WatchlistLoaded
                ? state.selectedWatchlist
                : (state as WatchlistReordering).selectedWatchlist;

            if (!_focusNode.hasFocus && _watchlistNameController.text != selectedWatchlist) {
              _watchlistNameController.text = selectedWatchlist;
            }

            return Column(
              children: [
                WatchlistNameField(
                  controller: _watchlistNameController,
                  focusNode: _focusNode,
                  onSubmitted: _submitNameChange,
                ),
                Expanded(
                  child: stocks.isEmpty
                      ? const EmptyState(
                          title: 'No stocks in watchlist',
                          subtitle: 'Add stocks to get started',
                          icon: Icons.list_alt,
                        )
                      : ReorderableStockList(stocks: stocks),
                ),
                EditWatchlistBottomButtons(state: state),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
