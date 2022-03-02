import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:mccounting_text/mccounting_text.dart';

class ActiveScreen extends StatefulWidget {
  @override
  State<ActiveScreen> createState() {
    return ActiveScreenState();
  }
}

class ActiveScreenState extends State<ActiveScreen> {
  var increaseColor = const Color(0xff2ecc71);
  var decreaseColor = const Color(0xffe74c3c);

  bool isIncrease = true;
  double minPrice = 0;
  double maxPrice = 0;
  double price = 0;
  double percentage = 0;
  double previousPrice = 0;

  ActiveScreenState() {
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      var data = await http.get(Uri.parse(
          'https://api.binance.com/api/v3/ticker/24hr?symbol=SOLUSDT'));
      var res = Map<String, dynamic>.from(json.decode(data.body));
      setState(() {
        previousPrice = price;
        price = double.parse(res['lastPrice']);
        percentage = double.parse(res['priceChangePercent']);
        if (percentage > 0) {
          isIncrease = true;
        } else {
          isIncrease = false;
        }
        percentage = percentage.abs();
        minPrice = double.parse(res['lowPrice']);
        maxPrice = double.parse(res['highPrice']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
          child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: CircularProgressIndicator(
          color: isIncrease ? increaseColor : decreaseColor,
          strokeWidth: 10,
          value: percentage / 100,
        ),
      )),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            McCountingText(
              begin: previousPrice,
              end: price,
              precision: 2,
              curve: Curves.decelerate,
              duration: const Duration(seconds: 1),
              style: TextStyle(
                color: increaseColor,
                fontSize: 30,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "SOL",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    child: Row(children: [
                  Icon(
                    Icons.arrow_downward,
                    color: decreaseColor,
                  ),
                  Text(
                    minPrice.toString(),
                    style: TextStyle(
                      color: decreaseColor,
                      fontSize: 14,
                      decoration: TextDecoration.none,
                    ),
                  )
                ])),
                Container(
                    child: Row(children: [
                  Icon(
                    Icons.arrow_upward,
                    color: increaseColor,
                  ),
                  Text(
                    maxPrice.toString(),
                    style: TextStyle(
                      color: increaseColor,
                      fontSize: 14,
                      decoration: TextDecoration.none,
                    ),
                  )
                ]))
              ],
            )
          ],
        ),
      )
    ]);
  }
}
