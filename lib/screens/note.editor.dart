import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:uniassist/widgets/default.scaffold.dart';
import 'package:zefyr/zefyr.dart';

class NoteEditor extends StatefulWidget {
  final String content;

  const NoteEditor({
    Key key,
    this.content,
  }) : super(key: key);

  @override
  _NoteEditorState createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  String currentContent;
  ZefyrController _controller;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    currentContent = widget.content;

    _focusNode = FocusNode();
    _loadDocument().then((document) {
      setState(() {
        _controller = ZefyrController(document);
      });
    });
  }

  void _saveDocument(BuildContext context) {
    // Notus documents can be easily serialized to JSON by passing to
    // `jsonEncode` directly
    currentContent = jsonEncode(_controller.document);
    // For this example we save our document to a temporary file.
    // final file = File(Directory.systemTemp.path + "/quick_start.json");
    // And show a snack bar on success.
    // file.writeAsString(contents).then((_) {
    // Scaffold.of(context).showSnackBar(SnackBar(content: Text("Saved.")));
    // });
  }

  Future<NotusDocument> _loadDocument() async {
    // final file = File(Directory.systemTemp.path + "/quick_start.json");
    // if (await file.exists()) {
    // final contents = await file.readAsString();
    return NotusDocument.fromJson(jsonDecode(widget.content));
    //   }
    //   final Delta delta = Delta()..insert("Zefyr Quick Start\n");
    //   return NotusDocument.fromDelta(delta);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: 'NOTE CONTENT',
      hPadding: false,
      body: _controller == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ZefyrScaffold(
              child: ZefyrEditor(
                padding: EdgeInsets.all(16),
                controller: _controller,
                focusNode: _focusNode,
                physics: BouncingScrollPhysics(),
              ),
            ),
      icon: Icon(Feather.save),
      action: () {
        _saveDocument(context);
        Navigator.pop(context, currentContent);
      },
    );
  }
}
