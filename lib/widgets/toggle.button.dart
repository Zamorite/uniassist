import 'package:flutter/material.dart';
import 'package:uniassist/utils/constants.dart';

class ToggleButton extends StatelessWidget {
  final String title;
  final bool selected;
  final Function toggle;

  const ToggleButton({
    Key key,
    this.title,
    this.selected = false,
    this.toggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => toggle(),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: kHeight(context) * .02,
          horizontal: kWidth(context) * .06,
        ),
        decoration: BoxDecoration(
          color: selected ? kDarkGray : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }
}
