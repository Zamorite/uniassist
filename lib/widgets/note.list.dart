import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uniassist/models/note.dart';
import 'package:uniassist/models/task.dart';
import 'package:uniassist/utils/constants.dart';
import 'package:uniassist/widgets/notelist.tile.dart';
import 'package:uniassist/widgets/tasklist.tile.dart';

class NoteList extends StatefulWidget {
  const NoteList({
    Key key,
  }) : super(key: key);

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  buildTiles(List<Note> notes) {
    List<Widget> tiles = [];

    if (notes != null) {
      for (var note in notes) {
        tiles.add(
          NoteListTile(
            note: note,
          ),
        );
      }
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    List<Note> notes = Provider.of<List<Note>>(context);

    return notes == null || notes.length == 0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: kHeight(context) * .03,
                ),
                child: Icon(
                  Feather.circle,
                  size: 72,
                ),
              ),
              Text(
                'YOU HAVE\nNO NOTES YET',
                style: kH1.copyWith(
                  fontSize: 36,
                  height: .85,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )
        // : Center(child: Text(notes.length.toString()));
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) => NoteListTile(
              note: notes[index],
            ),
          );
  }
}
