import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:sky_city_quiz/pages/utils/containers.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final Uri _url = Uri.parse(
      'https://www.termsfeed.com/live/edd09286-675f-43f6-9f56-26ea4139b543');

  Future<void> _launchUrl() async {
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not launch $_url');
    }
  }

  final InAppReview inAppReview = InAppReview.instance;

  // Function to handle "Rate Us" action
  Future<void> _rateApp() async {
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview(); // In-app review request
    } else {
      // If in-app review is not available, open the store listing
      inAppReview.openStoreListing(
          appStoreId: 'YOUR_APP_STORE_ID'); // Replace with your App Store ID
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildBackground(context),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: Text(
              'Settings',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 40,
                  fontFamily: "Ingrid"),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Privacy Policy Container
                GestureDetector(
                  onTap: _launchUrl,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 5)
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.policy, color: Colors.white),
                        SizedBox(width: 10),
                        Text('Privacy Policy',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    ),
                  ),
                ),

                // Terms of Service Container
                GestureDetector(
                  onTap: _launchUrl,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 5)
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.gavel, color: Colors.white),
                        SizedBox(width: 10),
                        Text('Terms of Service',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    ),
                  ),
                ),

                // Rate Us Container
                GestureDetector(
                  onTap: _rateApp,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 5)
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star_rate, color: Colors.white),
                        SizedBox(width: 10),
                        Text('Rate Us',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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

  // Function to show the Rate Us dialog (example)
}
