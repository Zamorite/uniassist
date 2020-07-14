import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:random_string/random_string.dart';
import 'package:uniassist/models/Info.dart';
import 'package:uniassist/models/note.dart';
import 'package:uniassist/models/task.dart';
import 'package:uniassist/screens/date_picker.screen.dart';
import 'package:uniassist/screens/note.editor.dart';
import 'package:uniassist/services/auth.service.dart';
import 'package:uniassist/services/note.service.dart';
import 'package:uniassist/services/task.service.dart';
import 'package:uniassist/utils/constants.dart';
import 'package:uniassist/utils/service.locator.dart';
import 'package:uniassist/widgets/default.scaffold.dart';
import 'package:uniassist/widgets/toggle.button.dart';

class NewNoteScreen extends StatefulWidget {
  final Note note;

  const NewNoteScreen({
    Key key,
    this.note,
  }) : super(key: key);

  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  final _formKey = GlobalKey<FormState>();

  NoteService _noteService = locator.get<NoteService>();

  Note note;

  resetNote() {
    setState(() {
      note = widget.note == null
          ? Note(
              title: '',
              content: '',
              id: randomAlphaNumeric(28),
              ownerId: '',
              type: kTaskTypes[0],
              period: DateTime.now(),
              // status: '',
            )
          : widget.note;
    });
  }

  // setType(String type) {
  //   type
  // }

  setPeriod(DateTime period) {
    setState(() {
      note.period = period ?? note.period;
    });
    print('Set State: $period');
  }

  List<Widget> buildTypes() {
    List<Widget> widgets = [];

    // for (var type in kTaskTypes) {
    //   widgets.add(
    //     Expanded(
    //       child: ToggleButton(
    //         title: type,
    //         selected: note.type == type,
    //         toggle: () => setState(
    //           () {
    //             task.type = type;
    //           },
    //         ),
    //       ),
    //     ),
    //   );
    // }

    return widgets;
  }

  @override
  void initState() {
    super.initState();
    resetNote();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      body: Builder(
        builder: (BuildContext context) => DefaultScaffold(
          title: '${widget.note == null ? 'ADD' : 'EDIT'} NOTE',
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
                    initialValue: note.title,
                    onChanged: (text) {
                      note.title = text;

                      Delta delta = Delta()..insert('$text\n');

                      note.content = json.encode(delta);
                    },
                    validator: (String text) {
                      if ([null, ''].contains(text.trim())) {
                        return 'Your note should have a title. 😉';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(width: 100),
                      ),
                      labelText: 'Note Title',
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
                          child: Text('Note Content'),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              Navigator.of(context)
                                  .push(
                                    MaterialPageRoute(
                                      builder: (context) => NoteEditor(
                                        content: note.content,
                                      ),
                                    ),
                                  )
                                  .then((content) => note.content = content);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: kHeight(context) * .02,
                              horizontal: kWidth(context) * .06,
                            ),
                            decoration: BoxDecoration(
                              color: kDarkGray,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text('Edit Note Content'),
                                ),
                                Icon(Feather.feather),
                              ],
                            ),
                          ),
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
                                  initialDate: note.period,
                                ),
                              ),
                            )
                            .then(
                              (period) => setPeriod(period),
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
                                  '${note.period.day}.${note.period.month}.${note.period.year}'),
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
                if (widget.note == null) {
                  // Flushbar(
                  //   margin: EdgeInsets.symmetric(
                  //       vertical: kHeight(context) * .03,
                  //       horizontal: kWidth(context) * .03),
                  //   borderRadius: 10,
                  //   message: 'Your new note is on it\'s way to the DB',
                  //   flushbarStyle: FlushbarStyle.FLOATING,
                  //   title: 'Adding Note',
                  //   duration: Duration(seconds: 3),
                  //   icon: Icon(
                  //     Feather.check,
                  //     color: kOrange,
                  //   ),
                  //   shouldIconPulse: true,
                  // )..show(context);

                  note.ownerId = user.uid;
                  Info info = widget.note == null
                      ? await _noteService.addNote(note)
                      : await _noteService.updateNote(note);

                  if (info.success) {
                    _formKey.currentState.reset();
                    resetNote();
                    Flushbar(
                      margin: EdgeInsets.symmetric(
                          vertical: kHeight(context) * .03,
                          horizontal: kWidth(context) * .03),
                      borderRadius: 10,
                      message: 'Your new note is already in the DB',
                      flushbarStyle: FlushbarStyle.FLOATING,
                      title: 'Note Saved',
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
                      message: 'Your note could not be saved',
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
                  //   message: 'Your note is being updated',
                  //   flushbarStyle: FlushbarStyle.FLOATING,
                  //   title: 'Updating Note',
                  //   duration: Duration(seconds: 3),
                  //   icon: Icon(
                  //     Feather.check,
                  //     color: kOrange,
                  //   ),
                  //   shouldIconPulse: true,
                  // )..show(context);

                  note.ownerId = user.uid;
                  Info info = widget.note == null
                      ? await _noteService.addNote(note)
                      : await _noteService.updateNote(note);

                  if (info.success) {
                    _formKey.currentState.reset();
                    resetNote();
                    Flushbar(
                      margin: EdgeInsets.symmetric(
                          vertical: kHeight(context) * .03,
                          horizontal: kWidth(context) * .03),
                      borderRadius: 10,
                      message: 'Your note has been updated',
                      flushbarStyle: FlushbarStyle.FLOATING,
                      title: 'Note Updated',
                      duration: Duration(seconds: 1),
                      icon: Icon(
                        Feather.check,
                        color: kOrange,
                      ),
                      shouldIconPulse: true,
                    )..show(context)
                        .then((value) => Navigator.pop(context, note));
                  } else {
                    Flushbar(
                      margin: EdgeInsets.symmetric(
                          vertical: kHeight(context) * .03,
                          horizontal: kWidth(context) * .03),
                      borderRadius: 10,
                      message: 'Your note could not be updated',
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
