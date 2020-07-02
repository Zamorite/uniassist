import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uniassist/models/Info.dart';
import 'package:uniassist/models/task.dart';
import 'package:uniassist/screens/new_task.screen.dart';
import 'package:uniassist/services/moment.service.dart';
import 'package:uniassist/services/task.service.dart';
import 'package:uniassist/utils/constants.dart';
import 'package:uniassist/utils/service.locator.dart';

class TaskListTile extends StatelessWidget {
  final Task task;

  const TaskListTile({
    Key key,
    this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MomentService _momentService = locator.get<MomentService>();
    TaskService _taskService = locator.get<TaskService>();
    SlidableController _slidableCtrl = Provider.of<SlidableController>(context);

    return Padding(
      padding: EdgeInsets.only(bottom: kHeight(context) * .02),
      child: Slidable(
        // enabled: false,

        actionPane: SlidableBehindActionPane(),
        controller: _slidableCtrl,
        actionExtentRatio: 0.25,
        secondaryActions: task.done
            ? [
                Builder(
                  builder: (BuildContext context) => GestureDetector(
                    onTap: () async {
                      Slidable.of(context).close();
                      Info info = await _taskService.deleteTask(task);

                      if (info.success) {
                        Flushbar(
                          margin: EdgeInsets.symmetric(
                              vertical: kHeight(context) * .03,
                              horizontal: kWidth(context) * .03),
                          borderRadius: 10,
                          message: 'The task has been deleted successfully.',
                          flushbarStyle: FlushbarStyle.FLOATING,
                          title: 'Task Deleted',
                          duration: Duration(seconds: 3),
                          icon: Icon(
                            Feather.trash_2,
                            color: kOrange,
                          ),
                          shouldIconPulse: true,
                        )..show(context);
                      } else {
                        Flushbar(
                          margin: EdgeInsets.symmetric(
                              vertical: kHeight(context) * .03,
                              horizontal: kWidth(context) * .03),
                          borderRadius: 10,
                          message: 'Your task could not be deleted',
                          flushbarStyle: FlushbarStyle.FLOATING,
                          title: info.message,
                          duration: Duration(seconds: 3),
                          icon: Icon(
                            Feather.x,
                            color: kOrange,
                          ),
                          shouldIconPulse: true,
                        )..show(context);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: kWidth(context) * .02,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          // color: kOrange,
                          color: kLightGray,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(Feather.trash_2),
                        ),
                      ),
                    ),
                  ),
                ),

                Builder(
                  builder: (BuildContext context) => GestureDetector(
                    onTap: () async {
                      Slidable.of(context).close();
                      Info info = await _taskService.undoTask(task);

                      if (info.success) {
                        Flushbar(
                          margin: EdgeInsets.symmetric(
                              vertical: kHeight(context) * .03,
                              horizontal: kWidth(context) * .03),
                          borderRadius: 10,
                          message: 'The task has been marked as complete.',
                          flushbarStyle: FlushbarStyle.FLOATING,
                          title: 'Task Completed',
                          duration: Duration(seconds: 3),
                          icon: Icon(
                            Feather.trash_2,
                            color: kOrange,
                          ),
                          shouldIconPulse: true,
                        )..show(context);
                      } else {
                        Flushbar(
                          margin: EdgeInsets.symmetric(
                              vertical: kHeight(context) * .03,
                              horizontal: kWidth(context) * .03),
                          borderRadius: 10,
                          message: 'Your task could not be marked as complete',
                          flushbarStyle: FlushbarStyle.FLOATING,
                          title: info.message,
                          duration: Duration(seconds: 3),
                          icon: Icon(
                            Feather.x,
                            color: kOrange,
                          ),
                          shouldIconPulse: true,
                        )..show(context);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: kWidth(context) * .02,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          // color: kOrange,
                          color: kLightGray,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(Feather.rotate_ccw),
                        ),
                      ),
                    ),
                  ),
                ),
                // IconSlideAction(
                //   caption: 'Archive',
                //   color: Colors.blue,
                //   // icon: Icons.archive,
                //   onTap: () => null,
                // ),
                // IconSlideAction(
                //   caption: 'Share',
                //   color: Colors.indigo,
                //   // icon: Icons.share,
                //   onTap: () => null,
                // ),
              ]
            : [
                Builder(
                  builder: (BuildContext context) => GestureDetector(
                    onTap: () async {
                      Slidable.of(context).close();
                      Info info = await _taskService.deleteTask(task);

                      if (info.success) {
                        Flushbar(
                          margin: EdgeInsets.symmetric(
                              vertical: kHeight(context) * .03,
                              horizontal: kWidth(context) * .03),
                          borderRadius: 10,
                          message: 'The task has been deleted successfully.',
                          flushbarStyle: FlushbarStyle.FLOATING,
                          title: 'Task Deleted',
                          duration: Duration(seconds: 3),
                          icon: Icon(
                            Feather.trash_2,
                            color: kOrange,
                          ),
                          shouldIconPulse: true,
                        )..show(context);
                      } else {
                        Flushbar(
                          margin: EdgeInsets.symmetric(
                              vertical: kHeight(context) * .03,
                              horizontal: kWidth(context) * .03),
                          borderRadius: 10,
                          message: 'Your task could not be deleted',
                          flushbarStyle: FlushbarStyle.FLOATING,
                          title: info.message,
                          duration: Duration(seconds: 3),
                          icon: Icon(
                            Feather.x,
                            color: kOrange,
                          ),
                          shouldIconPulse: true,
                        )..show(context);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: kWidth(context) * .02,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          // color: kOrange,
                          color: kLightGray,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(Feather.trash_2),
                        ),
                      ),
                    ),
                  ),
                ),

                Builder(
                  builder: (BuildContext context) => GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (context) => NewTaskScreen(
                                task: task,
                              ),
                            ),
                          )
                          .then(
                            (value) => Slidable.of(context).close(),
                          );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: kWidth(context) * .02,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: kLightGray,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(Feather.feather),
                        ),
                      ),
                    ),
                  ),
                ),

                Builder(
                  builder: (BuildContext context) => GestureDetector(
                    onTap: () async {
                      Slidable.of(context).close();
                      Info info = await _taskService.doTask(task);

                      if (info.success) {
                        Flushbar(
                          margin: EdgeInsets.symmetric(
                              vertical: kHeight(context) * .03,
                              horizontal: kWidth(context) * .03),
                          borderRadius: 10,
                          message: 'The task has been marked as complete.',
                          flushbarStyle: FlushbarStyle.FLOATING,
                          title: 'Task Completed',
                          duration: Duration(seconds: 3),
                          icon: Icon(
                            Feather.trash_2,
                            color: kOrange,
                          ),
                          shouldIconPulse: true,
                        )..show(context);
                      } else {
                        Flushbar(
                          margin: EdgeInsets.symmetric(
                              vertical: kHeight(context) * .03,
                              horizontal: kWidth(context) * .03),
                          borderRadius: 10,
                          message: 'Your task could not be marked as complete',
                          flushbarStyle: FlushbarStyle.FLOATING,
                          title: info.message,
                          duration: Duration(seconds: 3),
                          icon: Icon(
                            Feather.x,
                            color: kOrange,
                          ),
                          shouldIconPulse: true,
                        )..show(context);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: kWidth(context) * .02,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          // color: kOrange,
                          color: kLightGray,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(Feather.check),
                        ),
                      ),
                    ),
                  ),
                ),
                // IconSlideAction(
                //   caption: 'Archive',
                //   color: Colors.blue,
                //   // icon: Icons.archive,
                //   onTap: () => null,
                // ),
                // IconSlideAction(
                //   caption: 'Share',
                //   color: Colors.indigo,
                //   // icon: Icons.share,
                //   onTap: () => null,
                // ),
              ],

        child: Builder(
          builder: (BuildContext context) => GestureDetector(
            onTap: () => Slidable.of(context).open(
              actionType: SlideActionType.secondary,
            ),
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
                dense: true,
                title: Text(
                  task.content,
                  style: kTaskListTextStyle,
                ),
                subtitle: Text(
                  task.type,
                  style: TextStyle(
                    fontSize: 12,
                    color: kLightGray,
                    // fontFamily: 'Teko',
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () => null,
                  child: _momentService.getDifference(task.deadline),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
