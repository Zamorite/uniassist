import 'package:flutter/material.dart';
import 'package:uniassist/utils/constants.dart';

class MomentService {
  Widget getDifference(DateTime deadline) {
    String leading, trailing;
    bool late = false;

    DateTime today = DateTime.now();

    bool overdue = deadline.isBefore(today);

    Duration diff = today.difference(deadline);

    if (overdue) {
      if (diff.inDays >= 1) {
        leading = diff.inDays.abs().toString();
        trailing = 'DAY${diff.inDays.abs() > 1 ? 'S' : ''} AGO';
        late = true;
      } else {
        trailing = 'TODAY';
      }
    } else {
      if (diff.inDays >= 1) {
        trailing = 'TODAY';
      } else {
        leading = 'IN';
        trailing =
            '${diff.inDays.abs()} DAY${diff.inDays.abs() > 1 ? 'S' : ''}';
        late = false;
      }
    }

    Widget text = Text(
      '${[null, ''].contains(leading) ? '' : leading + ' '}$trailing',
      style: kActionTextStyle.copyWith(
        color: late ? kOrange : Colors.white,
      ),
    );

    return text;
  }
}
