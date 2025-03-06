import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// MyProvider class (already provided)
class MyProvider extends ChangeNotifier {
  int _coins = 0; // Start with 0 coins
  final List<Map<String, dynamic>> _purchased = [];

  int get coins => _coins;
  List<Map<String, dynamic>> get purchased => _purchased;

  void addCoins(int amount) {
    _coins += amount;
    notifyListeners();
  }

  void deductCoins(int amount) {
    if (_coins >= amount) {
      _coins -= amount;
      notifyListeners();
    }
  }

  bool buyItem(Map<String, dynamic> item) {
    final int price = int.parse(item['price']);
    if (_coins >= price) {
      _coins -= price;
      _purchased.add(item);
      notifyListeners();
      return true;
    }
    return false;
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child: QuizApp(),
    ),
  );
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingsPage(),
    );
  }
}

// SettingsPage with containers for Privacy Policy, Terms of Service, and Rate Us
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Privacy Policy Container
            GestureDetector(
              onTap: () {
                _showPrivacyPolicy(context);
              },
              child: Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
                ),
                child: Row(
                  children: [
                    Icon(Icons.policy, color: Colors.white),
                    SizedBox(width: 10),
                    Text('Privacy Policy',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ),
            ),

            // Terms of Service Container
            GestureDetector(
              onTap: () {
                _showTermsOfService(context);
              },
              child: Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
                ),
                child: Row(
                  children: [
                    Icon(Icons.gavel, color: Colors.white),
                    SizedBox(width: 10),
                    Text('Terms of Service',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ),
            ),

            // Rate Us Container
            GestureDetector(
              onTap: () {
                _rateUs(context);
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
                ),
                child: Row(
                  children: [
                    Icon(Icons.star_rate, color: Colors.white),
                    SizedBox(width: 10),
                    Text('Rate Us',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show the Privacy Policy dialog (example)
  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Privacy Policy'),
          content: Text('Here you can place your Privacy Policy details.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // Function to show the Terms of Service dialog (example)
  void _showTermsOfService(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Terms of Service'),
          content: Text('Here you can place your Terms of Service details.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // Function to show the Rate Us dialog (example)
  void _rateUs(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rate Us'),
          content: Text('Would you like to rate our app?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // In a real app, this could link to the app store
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }
}
