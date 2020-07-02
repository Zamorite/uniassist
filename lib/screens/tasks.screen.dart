import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uniassist/models/task.dart';
import 'package:uniassist/screens/new_task.screen.dart';
import 'package:uniassist/screens/profile.screen.dart';
import 'package:uniassist/services/task.service.dart';
import 'package:uniassist/utils/constants.dart';
import 'package:uniassist/utils/service.locator.dart';
import 'package:uniassist/widgets/all_tasks.list.dart';
import 'package:uniassist/widgets/default.scaffold.dart';
import 'package:uniassist/widgets/done_tasks.list.dart';
import 'package:uniassist/widgets/tasklist.tile.dart';
import 'package:uniassist/widgets/tasks_today.list.dart';

class TasksScreen extends StatelessWidget {
  TaskService taskService = locator.get<TaskService>();

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    return DefaultScaffold(
      title: 'TASKS',
      icon: Icon(
        // Fontisto.search,
        // Fontisto.file_1,
        // Feather.user,
        Feather.bar_chart_2,
        // Feather.activity,
        color: kLightGray,
        size: 24,
      ),
      action: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProfileScreen(),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          children: <Widget>[
            TabBar(
              // isScrollable: true,
              // labelPadding:
              //     EdgeInsets.only(left: 0, right: kWidth(context) * .12),
              // indicatorPadding:
              //     EdgeInsets.only(left: 0, right: kWidth(context) * .12),
              labelStyle: TextStyle(fontFamily: 'Teko', fontSize: 24),
              // indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  text: 'TO DO',
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
                  physics: BouncingScrollPhysics(),
                  children: [
                    MultiProvider(
                      providers: [
                        StreamProvider<List<Task>>.value(
                          value: taskService.streamTodoTasks(user),
                        ),
                        Provider<SlidableController>(
                          create: (context) => SlidableController(),
                        ),
                      ],
                      child: TodayTasks(),
                    ),
                    MultiProvider(
                      providers: [
                        StreamProvider<List<Task>>.value(
                          value: taskService.streamDoneTasks(user),
                        ),
                        Provider<SlidableController>(
                          create: (context) => SlidableController(),
                        ),
                      ],
                      child: AllTasks(),
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
    );
  }
}
