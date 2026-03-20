import 'package:flutter/material.dart';
import '../models/stock.dart';

class StockList extends StatelessWidget {
  final List<Stock> stocks;

  const StockList({
    super.key,
    required this.stocks,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: stocks.length,
      separatorBuilder: (context, index) => const Divider(height: 1, thickness: 0.5),
      itemBuilder: (context, index) {
        final stock = stocks[index];

        return ListTile(
          onTap: () {},
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          title: Text(stock.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          subtitle: Text(stock.exchangeDisplay, style: TextStyle(color: Colors.grey[400], fontSize: 11)),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                stock.formattedPrice,
                style: TextStyle(
                  color: stock.isPositive ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                stock.formattedChange,
                style: TextStyle(color: Colors.grey[400], fontSize: 11),
              ),
            ],
          ),
        );
      },
    );
  }
}
