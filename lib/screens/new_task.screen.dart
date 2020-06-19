import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:uniassist/models/task.dart';
import 'package:uniassist/utils/constants.dart';
import 'package:uniassist/widgets/default.scaffold.dart';
import 'package:uniassist/widgets/toggle.button.dart';

class NewTaskScreen extends StatefulWidget {
  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  Task task = Task(
      content: 'Write an article about Design Patterns',
      id: '',
      ownerId: '',
      type: kTaskTypes[0],
      deadline: DateTime.now(),
      status: '');

  // setType(String type) {
  //   type
  // }

  List<Widget> buildTypes() {
    List<Widget> widgets = [];

    for (var type in kTaskTypes) {
      widgets.add(
        Expanded(
          child: ToggleButton(
            title: type,
            selected: task.type == type,
            toggle: () => setState(
              () {
                task.type = type;
              },
            ),
          ),
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: 'ADD TASK',
      action: () => null,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: kHeight(context) * .03,
            ),
            child: TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(width: 100),
                ),
                labelText: 'Task Name',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: kHeight(context) * .03,
            ),
            child: Container(
              // padding: EdgeInsets.symmetric(
              //   vertical: kHeight(context) * .03,
              //   horizontal: kWidth(context) * .06,
              // ),
              padding: EdgeInsets.only(
                bottom: kHeight(context) * .03,
                left: kWidth(context) * .06,
                right: kWidth(context) * .06,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: kHeight(context) * .03,
                      // horizontal: kWidth(context) * .06,
                    ),
                    child: Text('Task Type'),
                  ),
                  Row(
                    children: buildTypes(),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                border: Border.all(color: kDarkGray),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: kHeight(context) * .015,
                    horizontal: kWidth(context) * .06,
                  ),
                  decoration: BoxDecoration(
                    color: kDarkGray,
                    borderRadius: BorderRadius.circular(kWidth(context) * .25),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Feather.calendar),
                      ),
                      Text('17.06.2020'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      fab: FloatingActionButton(
        child: Icon(
          Feather.check,
          color: Colors.white,
        ),
        // onPressed: () => Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => Dashboard(),
        //   ),
        // ),
        onPressed: () => null,
      ),
    );
  }
}
