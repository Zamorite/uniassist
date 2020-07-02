import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uniassist/models/task.dart';
import 'package:uniassist/utils/constants.dart';
import 'package:uniassist/widgets/tasklist.tile.dart';

class DoneTasks extends StatefulWidget {
  const DoneTasks({
    Key key,
  }) : super(key: key);

  @override
  _DoneTasksState createState() => _DoneTasksState();
}

class _DoneTasksState extends State<DoneTasks> {
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
    List<Task> tasks; //Provider.of<List<Task>>(context);

    return tasks == null || tasks.length == 0
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
                'NO TASKS\nCOMPLETED YET',
                style: kH1.copyWith(
                  fontSize: 36,
                  height: .75,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )
        : ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              ListBody(
                children: buildTiles(tasks),
              ),
            ],
          );
  }
}
