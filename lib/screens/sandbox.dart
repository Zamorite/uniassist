import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uniassist/models/task.dart';
import 'package:uniassist/utils/constants.dart';
import 'package:uniassist/utils/theme.dart';
import 'package:uniassist/widgets/default.scaffold.dart';
import 'package:uniassist/widgets/setting.tile.dart';
import 'package:uniassist/widgets/tasklist.tile.dart';

class SandBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Task task = Task(
      content: 'Write an article about Design Patterns',
      id: '',
      ownerId: '',
      type: '',
      deadline: DateTime.now(),
      // status: '');
    );

    return DefaultScaffold(
      title: 'TASKS',
      icon: Icon(
        Fontisto.search,
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
              labelStyle: TextStyle(),
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
                        )
                      ],
                    ),
                    Container(),
                    Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      fab: FloatingActionButton(onPressed: null),
    );
  }
}
