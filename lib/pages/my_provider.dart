import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  int _coins = 0; // Start with 0 coins
  final List<Map<String, dynamic>> _purchased = [];

  int get coins => _coins;
  List<Map<String, dynamic>> get purchased => _purchased;

  void addCoins(int amount) {
    _coins += amount;
    print(
        "✅ Coins added: $amount | Total coins: $_coins"); // Vezi dacă funcționează
    notifyListeners();
  }

  void deductCoins(int amount) {
    if (_coins >= amount) {
      _coins -= amount;
      notifyListeners();
    }
  }

  bool buyItem(Map<String, dynamic> item) {
    final int price = int.parse(item['price']); // Convert price to int
    if (_coins >= price) {
      _coins -= price;
      _purchased.add(item);
      notifyListeners();
      return true;
    }
    return false;
  }
}
