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
        title: Text("Confirm Purchase",
            style: TextStyle(
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.w400,
                fontFamily: "Ingrid")),
        content: Text("Are you sure you want to buy it?",
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w300,
                fontFamily: "Ingrid")),
        actions: [
          CupertinoDialogAction(
            child: Text("Cancel",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Ingrid")),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: Text("Yes",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Ingrid")),
            onPressed: () {
              final provider = Provider.of<MyProvider>(context, listen: false);
              final previousCoins = provider.coins;

              provider.buyItem(item);
              Navigator.pop(context); // Close the dialog

              if (provider.coins < previousCoins) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("✅ ${item.title} purchased successfully!"),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("❌ Not enough coins!"),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ),
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
            leading: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ItemsPage(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Icon(
                    Icons.backpack_sharp,
                    color: Color(0xffFFB200),
                  ),
                )),
            actions: [
              Consumer<MyProvider>(
                builder: (context, provider, child) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage("images/Group 19.png"),
                          height: 25,
                        ),
                        SizedBox(width: 5),
                        Text(provider.coins.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xffFFB22C),
                            )),
                      ],
                    ),
                  );
                },
              ),
            ],
            title: Text("Shopping Store",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 40,
                    fontFamily: "Ingrid")),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: GridView.builder(
            padding: EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.6,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                            color: Color(0xffFABC3F)),
                      ),
                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${item.price} ",
                            style: TextStyle(
                                color: Color(0xffFFB22C),
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          buildWidth(context, 0.01),
                          Image(
                            image: AssetImage("images/Group 19.png"),
                            height: 25,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => _showConfirmationDialog(context, item),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              "Buy",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
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
