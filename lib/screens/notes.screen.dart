import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uniassist/models/note.dart';
import 'package:uniassist/models/task.dart';
import 'package:uniassist/screens/new_note.screen.dart';
import 'package:uniassist/screens/new_task.screen.dart';
import 'package:uniassist/screens/profile.screen.dart';
import 'package:uniassist/screens/settings.screen.dart';
import 'package:uniassist/services/note.service.dart';
import 'package:uniassist/services/task.service.dart';
import 'package:uniassist/utils/constants.dart';
import 'package:uniassist/utils/service.locator.dart';
import 'package:uniassist/widgets/all_tasks.list.dart';
import 'package:uniassist/widgets/default.scaffold.dart';
import 'package:uniassist/widgets/note.list.dart';
import 'package:uniassist/widgets/tasklist.tile.dart';
import 'package:uniassist/widgets/tasks_today.list.dart';

class NotesScreen extends StatelessWidget {
  NoteService noteService = locator.get<NoteService>();

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    return StreamProvider<List<Note>>.value(
      value: noteService.streamNotes(user),
      // catchError: (BuildContext context, error) => null,
      child: DefaultScaffold(
        title: 'NOTES',
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
        body: NoteList(),
        fab: FloatingActionButton(
          child: Icon(
            Feather.plus,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewNoteScreen(),
            ),
          ),
        ),
      ),
    );
  }
}
