import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/watchlist_bloc.dart';
import '../bloc/watchlist_event.dart';
import '../models/stock.dart';

class ReorderableStockList extends StatefulWidget {
  final List<Stock> stocks;

  const ReorderableStockList({
    super.key,
    required this.stocks,
  });

  @override
  State<ReorderableStockList> createState() => _ReorderableStockListState();
}

class _ReorderableStockListState extends State<ReorderableStockList> {
  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      buildDefaultDragHandles: false,
      padding: const EdgeInsets.only(top: 8),
      itemCount: widget.stocks.length,
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
        });
        context.read<WatchlistBloc>().add(
          ReorderStocks(oldIndex: oldIndex, newIndex: newIndex),
        );
      },
      itemBuilder: (context, index) {
        final stock = widget.stocks[index];

        return ReorderableDragStartListener(
          key: ValueKey(stock.name + index.toString()),
          index: index,
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(width: 14, height: 2.5, color: Colors.black),
                          const SizedBox(height: 4),
                          Container(width: 14, height: 2.5, color: Colors.black),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          stock.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.blueGrey[400], // Muted grey text
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                      IconButton(
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.black,
                          size: 22,
                        ),
                        onPressed: () {
                          _showDeleteConfirmation(context, stock.name);
                        },
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, thickness: 1, color: Colors.grey[200]),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, String stockName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Stock'),
          content: Text('Are you sure you want to remove $stockName from the watchlist?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<WatchlistBloc>().add(RemoveStock(stockName: stockName));
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }
}
