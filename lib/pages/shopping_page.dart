import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_city_quiz/pages/items_page.dart';
import 'package:sky_city_quiz/pages/my_provider.dart';
import 'package:sky_city_quiz/pages/buy_page.dart';
import 'package:sky_city_quiz/pages/utils/classes.dart';
import 'package:sky_city_quiz/pages/utils/containers.dart';

class ShoppingPage extends StatefulWidget {
  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  void _showConfirmationDialog(BuildContext context, Shopping item) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("Confirm Purchase"),
        content: Text("Are you sure you want to buy it?"),
        actions: [
          CupertinoDialogAction(
            child: Text("Cancel", style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: Text("Yes"),
            onPressed: () {
              final provider = Provider.of<MyProvider>(context, listen: false);

              if (provider.coins >= item.price) {
                provider.buyItem(item as Map<String, dynamic>);
                Navigator.pop(context); // Închide dialogul
              } else {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Not enough coins!")),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProvider>(context);

    return Stack(
      children: [
        buildBackground(context),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: Consumer<MyProvider>(
              builder: (context, provider, child) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.monetization_on, color: Colors.yellow),
                      SizedBox(width: 5),
                      Text(
                        provider.coins.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ItemsPage(),
                        ));
                  },
                  child: Icon(Icons.backpack_sharp))
            ],
            title: Text("SHOPPING STORE"),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: GridView.builder(
            padding: EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemCount: shoppingItems.length,
            itemBuilder: (context, index) {
              final item = shoppingItems[index];

              return Card(
                color: Colors.black,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          item.image,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.yellow),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "${item.price} Coins",
                        style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => _showConfirmationDialog(context, item),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text("Buy"),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
