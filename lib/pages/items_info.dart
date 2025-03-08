import 'package:flutter/material.dart';
import 'package:sky_city_quiz/pages/utils/containers.dart';

class ItemsInfo extends StatelessWidget {
  final Map<String, dynamic> item; // Item cumpărat

  const ItemsInfo({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildBackground(context),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "Purchase Successful",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  fontFamily: "Ingrid"),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Colors.white), // White back arrow
              onPressed: () {
                Navigator.pop(context); // Go back to the previous screen
              },
            ),
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildHeight(context, 0.15),
                Align(
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(item["image"], height: 150)),
                ),
                buildHeight(context, 0.04),
                Text(
                  "You bought  ${item["title"]}",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                buildHeight(context, 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Price: ${item["price"]}",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffFFB22C),
                          fontFamily: "Inria"),
                    ),
                    buildWidth(context, 0.02),
                    Image(image: AssetImage("images/Group 19.png"), height: 25),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
