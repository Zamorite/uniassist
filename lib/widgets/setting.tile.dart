import 'package:flutter/material.dart';
import 'package:uniassist/utils/constants.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final Widget trailing;

  const SettingTile({
    Key key,
    this.title,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kWidth(context) * .03,
        vertical: kHeight(context) * .01,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: kDarkGray,
          ),
        ),
      ),
      child: ListTile(
        title: Text(title),
        trailing: trailing,
      ),
    );
  }
}
