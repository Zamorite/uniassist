import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:uniassist/models/note.dart';
import 'package:uniassist/models/task.dart';
import 'package:uniassist/screens/note.screen.dart';
import 'package:uniassist/screens/notes.screen.dart';
import 'package:uniassist/utils/constants.dart';

class NoteListTile extends StatelessWidget {
  final Note note;

  const NoteListTile({
    Key key,
    this.note,
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
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteScreen(
                note: note,
              ),
            ),
          ),
          title: Text(
            note.title,
            style: kTaskListTextStyle,
          ),
          trailing: GestureDetector(
            onTap: () => null,
            child: Icon(Feather.file_text),
            // child: Text(
            //   '0/2',
            //   style: kActionTextStyle,
            // ),
          ),
        ),
      ),
    );
  }
}
