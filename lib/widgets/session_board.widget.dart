import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniassist/models/session.dart';

class SessionBoard extends StatelessWidget {
  const SessionBoard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Session> sessions = Provider.of(context);

    return Text(
      'COMPLETED: ${(sessions ?? []).length}',
      style: TextStyle(
        fontFamily: 'Teko',
        fontSize: 32,
        // height: .95,
      ),
    );
  }
}
