import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uniassist/models/task.dart';
import 'package:uniassist/screens/new_task.screen.dart';
import 'package:uniassist/services/task.service.dart';
import 'package:uniassist/utils/constants.dart';
import 'package:uniassist/utils/service.locator.dart';
import 'package:uniassist/widgets/all_tasks.list.dart';
import 'package:uniassist/widgets/default.scaffold.dart';
import 'package:uniassist/widgets/tasklist.tile.dart';
import 'package:uniassist/widgets/tasks_today.list.dart';

class TasksScreen extends StatelessWidget {
  TaskService taskService = locator.get<TaskService>();

  final Task task = Task(
    content: 'Write an article about Design Patterns',
    id: '',
    ownerId: '',
    type: '',
    deadline: DateTime.now(),
    // status: ''
  );

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    return StreamProvider<List<Task>>.value(
      value: taskService.streamTasks(user),
      // catchError: (BuildContext context, error) => null,
      child: DefaultScaffold(
        title: 'TASKS',
        icon: Icon(
          // Fontisto.search,
          Fontisto.file_1,
          color: kLightGray,
          size: 24,
        ),
        action: () => null,
        body: DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Column(
            children: <Widget>[
              TabBar(
                // isScrollable: true,
                labelPadding:
                    EdgeInsets.only(left: 0, right: kWidth(context) * .18),
                indicatorPadding:
                    EdgeInsets.only(left: 0, right: kWidth(context) * .18),
                labelStyle: TextStyle(fontFamily: 'Teko', fontSize: 24),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(
                    text: 'TODAY',
                  ),
                  Tab(
                    text: 'ALL',
                  ),
                  Tab(
                    text: 'DONE',
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: kHeight(context) * .03),
                  child: TabBarView(
                    children: [
                      TodayTasks(),
                      AllTasks(),
                      ListView(
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          ListBody(
                            children: <Widget>[
                              TaskListTile(
                                task: task,
                              ),
                              TaskListTile(
                                task: task,
                              ),
                              TaskListTile(
                                task: task,
                              ),
                              TaskListTile(
                                task: task,
                              ),
                              TaskListTile(
                                task: task,
                              ),
                              TaskListTile(
                                task: task,
                              ),
                              TaskListTile(
                                task: task,
                              ),
                              TaskListTile(
                                task: task,
                              ),
                              TaskListTile(
                                task: task,
                              ),
                              TaskListTile(
                                task: task,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        fab: FloatingActionButton(
          child: Icon(
            Feather.plus,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewTaskScreen(),
            ),
          ),
        ),
      ),
    );
  }
}
