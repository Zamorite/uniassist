import 'package:flutter/material.dart';
import 'package:uniassist/utils/constants.dart';

class DefaultScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final Function action;
  final bool hPadding;
  final Icon icon;
  final FloatingActionButton fab;

  const DefaultScaffold({
    Key key,
    this.title,
    this.action,
    this.body,
    this.icon,
    this.fab,
    this.hPadding = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: kHeight(context) * .12,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: kDarkGray),
                ),
              ),
              // border: Border(bottom: BorderSide(color: kLightGray))),
              padding: EdgeInsets.symmetric(
                horizontal: kWidth(context) * .06,
                // vertical: kHeight(context) * .03,
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title,
                    style: kH1,
                  ),
                  GestureDetector(
                    onTap: () => action(),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kWidth(context) * .03,
                        // vertical: kHeight(context) * .03,
                      ),
                      child: Center(child: icon),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: hPadding
                    ? EdgeInsets.symmetric(
                        horizontal: kWidth(context) * .06,
                        vertical: kHeight(context) * .03,
                      )
                    : EdgeInsets.symmetric(
                        vertical: kHeight(context) * .03,
                      ),
                child: body,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: fab,
    );
  }
}
