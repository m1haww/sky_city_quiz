import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_city_quiz/pages/items_info.dart';
import 'package:sky_city_quiz/pages/my_provider.dart';
import 'package:sky_city_quiz/pages/utils/containers.dart';

class ItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProvider>(context);
    final purchasedItems = provider.purchased; // Lista cu produsele cumpărate

    return Stack(
      children: [
        buildBackground(context),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Colors.white), // White back arrow
              onPressed: () {
                Navigator.pop(context); // Go back to the previous screen
              },
            ),
            backgroundColor: Colors.transparent,
            title: Text(
              "Purchased Items",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 40,
                  fontFamily: "Ingrid"),
            ),
            centerTitle: true,
          ),
          body: purchasedItems.isEmpty
              ? Center(
                  child: Text(
                    "No items purchased yet!",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: purchasedItems.length,
                  itemBuilder: (context, index) {
                    final item = purchasedItems[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemsInfo(item: item),
                          ),
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              item["image"],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            item["title"],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                "Price: ${item["price"]}",
                                style: TextStyle(
                                    color: Color(0xffFFB22C),
                                    fontFamily: "Inria"),
                              ),
                              buildWidth(context, 0.02),
                              Image(
                                  image: AssetImage("images/Group 19.png"),
                                  height: 20),
                            ],
                          ),
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
