import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_city_quiz/pages/my_provider.dart';

class ItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProvider>(context);
    final purchasedItems = provider.purchased; // Lista cu produsele cumpărate

    return Scaffold(
      appBar: AppBar(
        title: Text("Purchased Items"),
        centerTitle: true,
      ),
      body: purchasedItems.isEmpty
          ? Center(
              child: Text(
                "No items purchased yet!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: purchasedItems.length,
              itemBuilder: (context, index) {
                final item = purchasedItems[index];

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: ListTile(
                    leading: Image.asset(
                      item["image"],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      item["title"],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Price: ${item["price"]} Coins",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
