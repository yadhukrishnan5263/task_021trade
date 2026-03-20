import 'package:flutter/material.dart';

class IndexTile extends StatelessWidget {
  final String title;
  final String price;
  final String change;
  final bool isPositive;

  const IndexTile({
    super.key,
    required this.title,
    required this.price,
    required this.change,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.black)),
              const SizedBox(width: 4),
              const Text("BSE", style: TextStyle(fontSize: 9, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(price, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black)),
              const SizedBox(width: 4),
              Text(
                change,
                style: TextStyle(fontSize: 10, color: isPositive ? Colors.green : Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
