import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey[400],
      selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline), label: 'Watchlist'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Orders'),
        BottomNavigationBarItem(icon: Icon(Icons.bolt), label: 'GTT+'),
        BottomNavigationBarItem(icon: Icon(Icons.work_outline), label: 'Portfolio'),
        BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Funds'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    );
  }
}
