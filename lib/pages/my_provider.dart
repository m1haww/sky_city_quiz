import 'package:flutter/material.dart';
import 'package:sky_city_quiz/pages/utils/classes.dart';

class MyProvider extends ChangeNotifier {
  int _coins = 0; // Start with 0 coins
  final List<Map<String, dynamic>> _purchased = [];

  int get coins => _coins;
  List<Map<String, dynamic>> get purchased => _purchased;

  void addCoins(int amount) {
    _coins += amount;
    print("✅ Coins added: $amount | Total coins: $_coins"); // Check if it works
    notifyListeners();
  }

  void deductCoins(int amount) {
    if (_coins >= amount) {
      _coins -= amount;
      notifyListeners();
    }
  }

  // Update buyItem method to use _coins and add the purchased item
  void buyItem(Shopping item) {
    if (_coins >= item.price) {
      _coins -= item.price; // Deduct coins
      _purchased.add({
        'image': item.image,
        'title': item.title,
        'price': item.price,
      }); // Add the purchased item to the list
      notifyListeners(); // Notify listeners for UI updates
    } else {
      print("Not enough coins!"); // Optional: handle not enough coins
    }
  }
}
