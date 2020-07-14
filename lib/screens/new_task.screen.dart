import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:uniassist/models/Info.dart';
import 'package:uniassist/models/task.dart';
import 'package:uniassist/screens/date_picker.screen.dart';
import 'package:uniassist/services/auth.service.dart';
import 'package:uniassist/services/task.service.dart';
import 'package:uniassist/utils/constants.dart';
import 'package:uniassist/utils/service.locator.dart';
import 'package:uniassist/widgets/default.scaffold.dart';
import 'package:uniassist/widgets/toggle.button.dart';

class NewTaskScreen extends StatefulWidget {
  final Task task;

  const NewTaskScreen({
    Key key,
    this.task,
  }) : super(key: key);

  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  TaskService _taskService = locator.get<TaskService>();

  Task task;

  resetTask() {
    setState(
      () {
        task = widget.task == null
            ? Task(
                content: '',
                id: randomAlphaNumeric(28),
                ownerId: '',
                type: kTaskTypes[0],
                deadline: DateTime.now(),
                done: false,
              )
            : widget.task;
      },
    );
  }

  // setType(String type) {
  //   type
  // }

  setDeadline(DateTime deadline) {
    setState(() {
      task.deadline = deadline ?? task.deadline;
    });
    print('Set State: $deadline');
  }

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
  void initState() {
    super.initState();
    resetTask();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      body: Builder(
        builder: (BuildContext context) => DefaultScaffold(
          title: '${widget.task == null ? 'ADD' : 'EDIT'} TASK',
          action: () => null,
          body: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: kHeight(context) * .03,
                  ),
                  child: TextFormField(
                    initialValue: task.content,
                    onChanged: (text) => task.content = text,
                    validator: (String text) {
                      if ([null, ''].contains(text.trim())) {
                        return 'Your task should have a title. 😉';
                      } else {
                        return null;
                      }
                    },
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
                      child: GestureDetector(
                        onTap: () => Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (context) => DatePickerScreen(
                                  initialDate: task.deadline,
                                ),
                              ),
                            )
                            .then(
                              (deadline) => setDeadline(deadline),
                            ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: kHeight(context) * .015,
                            horizontal: kWidth(context) * .06,
                          ),
                          decoration: BoxDecoration(
                            color: kDarkGray,
                            borderRadius:
                                BorderRadius.circular(kWidth(context) * .25),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Icon(Feather.calendar),
                              ),
                              Text(
                                  '${task.deadline.day}.${task.deadline.month}.${task.deadline.year}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                if (widget.task == null) {
                  // Flushbar(
                  //   margin: EdgeInsets.symmetric(
                  //       vertical: kHeight(context) * .03,
                  //       horizontal: kWidth(context) * .03),
                  //   borderRadius: 10,
                  //   message: 'Your new task is on it\'s way to the DB',
                  //   flushbarStyle: FlushbarStyle.FLOATING,
                  //   title: 'Adding Task',
                  //   duration: Duration(seconds: 3),
                  //   icon: Icon(
                  //     Feather.check,
                  //     color: kOrange,
                  //   ),
                  //   shouldIconPulse: true,
                  // )..show(context);

                  task.ownerId = user.uid;
                  Info info = await _taskService.addTask(task);

                  if (info.success) {
                    _formKey.currentState.reset();
                    Flushbar(
                      margin: EdgeInsets.symmetric(
                          vertical: kHeight(context) * .03,
                          horizontal: kWidth(context) * .03),
                      borderRadius: 10,
                      message: 'Your new task is already in the DB',
                      flushbarStyle: FlushbarStyle.FLOATING,
                      title: 'Task Added',
                      duration: Duration(seconds: 1),
                      icon: Icon(
                        Feather.check,
                        color: kOrange,
                      ),
                      shouldIconPulse: true,
                    )..show(context).then((value) => Navigator.pop(context));
                  } else {
                    Flushbar(
                      margin: EdgeInsets.symmetric(
                          vertical: kHeight(context) * .03,
                          horizontal: kWidth(context) * .03),
                      borderRadius: 10,
                      message: 'Your task could not be added',
                      flushbarStyle: FlushbarStyle.FLOATING,
                      title: info.message,
                      duration: Duration(seconds: 1),
                      icon: Icon(
                        Feather.x,
                        color: kOrange,
                      ),
                      shouldIconPulse: true,
                    )..show(context);
                  }
                } else {
                  // Flushbar(
                  //   margin: EdgeInsets.symmetric(
                  //       vertical: kHeight(context) * .03,
                  //       horizontal: kWidth(context) * .03),
                  //   borderRadius: 10,
                  //   message: 'Your task is being updated',
                  //   flushbarStyle: FlushbarStyle.FLOATING,
                  //   title: 'Updating Task',
                  //   duration: Duration(seconds: 3),
                  //   icon: Icon(
                  //     Feather.check,
                  //     color: kOrange,
                  //   ),
                  //   shouldIconPulse: true,
                  // )..show(context);

                  task.ownerId = user.uid;
                  Info info = await _taskService.addTask(task);

                  if (info.success) {
                    _formKey.currentState.reset();
                    Flushbar(
                      margin: EdgeInsets.symmetric(
                          vertical: kHeight(context) * .03,
                          horizontal: kWidth(context) * .03),
                      borderRadius: 10,
                      message: 'Your task has been updated',
                      flushbarStyle: FlushbarStyle.FLOATING,
                      title: 'Task Updated',
                      duration: Duration(seconds: 1),
                      icon: Icon(
                        Feather.check,
                        color: kOrange,
                      ),
                      shouldIconPulse: true,
                    )..show(context).then((value) => Navigator.pop(context));
                  } else {
                    Flushbar(
                      margin: EdgeInsets.symmetric(
                          vertical: kHeight(context) * .03,
                          horizontal: kWidth(context) * .03),
                      borderRadius: 10,
                      message: 'Your task could not be updated',
                      flushbarStyle: FlushbarStyle.FLOATING,
                      title: info.message,
                      duration: Duration(seconds: 1),
                      icon: Icon(
                        Feather.x,
                        color: kOrange,
                      ),
                      shouldIconPulse: true,
                    )..show(context);
                  }
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
