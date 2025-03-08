import 'package:flutter/material.dart';
import 'package:sky_city_quiz/pages/utils/classes.dart';

class BuyPage extends StatefulWidget {
  final Shopping item;

  const BuyPage({Key? key, required this.item}) : super(key: key);

  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Purchase Successful",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 40,
              fontFamily: "Ingrid"),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(widget.item.image, height: 150),
            SizedBox(height: 20),
            Text(
              "You bought: ${widget.item.title}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Price: ${widget.item.price} Coins",
              style: TextStyle(fontSize: 18, color: Colors.orange),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Back to Store"),
            ),
          ],
        ),
      ),
    );
  }
}
