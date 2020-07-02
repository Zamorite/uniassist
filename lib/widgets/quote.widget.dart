import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:random_string/random_string.dart';
import 'package:uniassist/utils/constants.dart';

class QuoteWidget extends StatefulWidget {
  @override
  _QuoteWidgetState createState() => _QuoteWidgetState();
}

class _QuoteWidgetState extends State<QuoteWidget> {
  List quote;

  randomQuote({int current}) {
    int randomIndex = Random().nextInt(13);

    if (current != null && randomIndex == current) {
      randomQuote(current: current);
    } else {
      setState(() {
        quote = kQuotes[randomIndex];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    randomQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kHeight(context) * .03),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: kHeight(context) * .03,
          horizontal: kWidth(context) * .03,
        ),
        decoration: BoxDecoration(
          color: kDarkGray,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: <Widget>[
            Text(
              quote[1],
              style: TextStyle(
                fontSize: 18,
                color: kLightGray,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: kHeight(context) * .01,
              ),
              child: Divider(
                color: kLightGray,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  quote[2],
                  style: TextStyle(
                    color: kLightGray,
                    fontSize: 24,
                    height: .95,
                    fontFamily: 'Teko',
                  ),
                ),
                GestureDetector(
                  onTap: () => randomQuote(),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: kWidth(context) * .03),
                    child: Icon(
                      Feather.rotate_cw,
                      color: kOrange,
                      size: 18,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
