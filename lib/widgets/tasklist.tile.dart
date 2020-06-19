import 'package:flutter/material.dart';
import 'package:uniassist/models/task.dart';
import 'package:uniassist/utils/constants.dart';

class TaskListTile extends StatelessWidget {
  final Task task;

  const TaskListTile({
    Key key,
    this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: kHeight(context) * .02),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: kHeight(context) * .01,
          horizontal: kWidth(context) * .01,
        ),
        decoration: BoxDecoration(
          color: kDarkGray,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(
            task.content,
            style: kTaskListTextStyle,
          ),
          trailing: GestureDetector(
            onTap: () => null,
            child: Text(
              '0/2',
              style: kActionTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
