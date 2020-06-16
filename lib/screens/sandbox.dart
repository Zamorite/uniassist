import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniassist/utils/constants.dart';
import 'package:uniassist/utils/theme.dart';

class SandBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return new Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: height * .12,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: kDarkGray))),
              // border: Border(bottom: BorderSide(color: kLightGray))),
              padding: EdgeInsets.symmetric(
                horizontal: width * .06,
                vertical: height * .03,
              ),

              child: Text(
                'TASKS',
                style: kH1,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * .06,
                  vertical: height * .03,
                ),
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      child: Text('Dark Theme'),
                      onPressed: () => _themeChanger.setTheme(
                        kDarkTheme,
                      ),
                    ),
                    FlatButton(
                      child: Text('Light Theme'),
                      onPressed: () => _themeChanger.setTheme(
                        ThemeData.light(),
                      ),
                    ),
                    Card(
                      child: Container(
                        height: 300,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: null),
    );
  }
}
