import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:uniassist/screens/settings.screen.dart';
import 'package:uniassist/utils/constants.dart';
import 'package:uniassist/widgets/default.scaffold.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: 'PROFILE',
      icon: Icon(
        Fontisto.spinner_cog,
        color: kOrange,
        size: 36,
      ),
      action: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SettingsScreen(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: kWidth(context) * .06,
            ),
            child: Text('STATISTICS'),
          ),
          Container(
            height: kHeight(context) * .15,
            decoration: BoxDecoration(
              color: kDarkGray,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: kHeight(context) * .03),
              child: Container(
                // height: kHeight(context) * .15,
                decoration: BoxDecoration(
                  color: kDarkGray,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
