import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniassist/models/note.dart';
import 'package:uniassist/models/session.dart';
import 'package:uniassist/models/task.dart';
import 'package:uniassist/utils/constants.dart';

class StatBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Session> sessions = Provider.of(context);
    List<Task> tasks = Provider.of(context);
    List<Note> notes = Provider.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: kDarkGray,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'SESSIONS',
                style: TextStyle(
                  fontFamily: 'TEKO',
                  fontSize: 18,
                ),
                // textAlign: TextAlign.center,
              ),
              Text(
                'COMPLETED TASKS',
                style: TextStyle(
                  fontFamily: 'TEKO',
                  fontSize: 18,
                ),
                // textAlign: TextAlign.center,
              ),
              Text(
                'NOTES',
                style: TextStyle(
                  fontFamily: 'TEKO',
                  fontSize: 18,
                ),
                // textAlign: TextAlign.center,
              ),
            ],
          ),
          Divider(
            color: kLightGray,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                (sessions ?? []).length.toString(),
                style: TextStyle(
                  fontFamily: 'TEKO',
                  fontSize: 24,
                ),
              ),
              Text(
                (tasks ?? []).length.toString(),
                style: TextStyle(
                  fontFamily: 'TEKO',
                  fontSize: 24,
                ),
              ),
              Text(
                (notes ?? []).length.toString(),
                style: TextStyle(
                  fontFamily: 'TEKO',
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
