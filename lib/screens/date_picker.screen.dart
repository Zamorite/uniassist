import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:uniassist/widgets/default.scaffold.dart';

class DatePickerScreen extends StatelessWidget {
  final DateTime initialDate;
  DateTime finalDate;

  DatePickerScreen({
    Key key,
    this.initialDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: 'CALENDAR',
      body: Column(
        children: <Widget>[
          CalendarDatePicker(
            // initialCalendarMode: DatePickerMode.day,
            initialDate: initialDate,
            firstDate: initialDate,
            lastDate: DateTime.now().add(
              Duration(
                days: 90,
              ),
            ),
            onDateChanged: (DateTime date) => finalDate = date,
          ),
        ],
      ),
      fab: FloatingActionButton(
        child: Icon(Feather.check),
        onPressed: () {
          Navigator.pop(
            context,
            finalDate,
          );
        },
      ),
    );
  }
}
