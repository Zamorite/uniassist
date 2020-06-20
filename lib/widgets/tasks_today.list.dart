import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uniassist/models/task.dart';
import 'package:uniassist/utils/constants.dart';
import 'package:uniassist/widgets/tasklist.tile.dart';

class TodayTasks extends StatefulWidget {
  const TodayTasks({
    Key key,
  }) : super(key: key);

  @override
  _TodayTasksState createState() => _TodayTasksState();
}

class _TodayTasksState extends State<TodayTasks> {
  buildTiles(List<Task> tasks) {
    List<Widget> tiles = [];

    if (tasks != null) {
      for (var task in tasks) {
        tiles.add(
          TaskListTile(
            task: task,
          ),
        );
      }
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = Provider.of<List<Task>>(context);

    return tasks == null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: kHeight(context) * .03),
                child: Icon(
                  Feather.circle,
                  size: 72,
                ),
              ),
              Text(
                'NO TASKS\nFOR TODAY',
                style: kH1.copyWith(
                  fontSize: 36,
                  height: .75,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) =>
                TaskListTile(task: tasks[index]),
          );
  }
}
