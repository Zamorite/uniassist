import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:uniassist/models/Info.dart';
import 'package:uniassist/models/note.dart';
import 'package:uniassist/screens/new_note.screen.dart';
import 'package:uniassist/services/note.service.dart';
import 'package:uniassist/utils/constants.dart';
import 'package:uniassist/utils/service.locator.dart';
import 'package:uniassist/widgets/default.scaffold.dart';
import 'package:zefyr/zefyr.dart';

class NoteScreen extends StatefulWidget {
  final Note note;

  const NoteScreen({
    Key key,
    this.note,
  }) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  ZefyrController _controller;
  FocusNode _focusNode;
  NoteService _noteService = locator.get<NoteService>();

  @override
  void initState() {
    super.initState();

    // currentContent = widget.content;

    _focusNode = FocusNode();
    _loadDocument().then((document) {
      setState(() {
        _controller = ZefyrController(document);
      });
    });
  }

  Future<NotusDocument> _loadDocument() async {
    return NotusDocument.fromJson(jsonDecode(widget.note.content));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: widget.note.title,
      body: _controller == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                Expanded(
                  child: ZefyrScaffold(
                    child: ZefyrEditor(
                      padding: EdgeInsets.all(16),
                      controller: _controller,
                      focusNode: _focusNode,
                      mode: ZefyrMode.view,
                    ),
                  ),
                ),
              ],
            ),
      icon: Icon(Feather.trash_2),
      action: () async {
        Info info = await _noteService.deleteNote(widget.note);

        if (info.success) {
          Flushbar(
            margin: EdgeInsets.symmetric(
                vertical: kHeight(context) * .03,
                horizontal: kWidth(context) * .03),
            borderRadius: 10,
            message: 'The note has been deleted successfully.',
            flushbarStyle: FlushbarStyle.FLOATING,
            title: 'Note Deleted',
            duration: Duration(seconds: 3),
            icon: Icon(
              Feather.trash_2,
              color: kOrange,
            ),
            shouldIconPulse: true,
          )..show(context).then(
              (value) => Navigator.of(context).pop(),
            );
        } else {
          Flushbar(
            margin: EdgeInsets.symmetric(
                vertical: kHeight(context) * .03,
                horizontal: kWidth(context) * .03),
            borderRadius: 10,
            message: 'Your note could not be deleted',
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
      fab: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NewNoteScreen(
              note: widget.note,
            ),
          ),
        ),
        child: Icon(
          Feather.feather,
        ),
      ),
    );
  }
}
