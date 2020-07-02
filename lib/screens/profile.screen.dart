import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uniassist/models/session.dart';
import 'package:uniassist/screens/settings.screen.dart';
import 'package:uniassist/services/auth.service.dart';
import 'package:uniassist/services/note.service.dart';
import 'package:uniassist/services/session.service.dart';
import 'package:uniassist/services/task.service.dart';
import 'package:uniassist/utils/constants.dart';
import 'package:uniassist/utils/service.locator.dart';
import 'package:uniassist/widgets/chart.widget.dart';
import 'package:uniassist/widgets/default.scaffold.dart';
import 'package:uniassist/widgets/quote.widget.dart';
import 'package:uniassist/widgets/stat_bar.widget.dart';

class ProfileScreen extends StatelessWidget {
  SessionService _sessionService = locator.get<SessionService>();
  TaskService _taskService = locator.get<TaskService>();
  NoteService _noteService = locator.get<NoteService>();

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    AuthService authService = locator.get<AuthService>();

    return DefaultScaffold(
      title: 'STATS',
      icon: Icon(
        // Fontisto.spinner_cog,
        Feather.log_out,
        color: kLightGray,
        size: 24,
      ),
      // action: () => Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => SettingsScreen(),
      //   ),
      // ),
      action: () {
        authService.signout();
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      body: MultiProvider(
        providers: [
          StreamProvider(
            create: (context) => _sessionService.streamSessions(user),
          ),
          StreamProvider(
            create: (context) => _taskService.streamDoneTasks(user),
          ),
          StreamProvider(
            create: (context) => _noteService.streamNotes(user),
          ),
        ],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: kWidth(context) * .03,
                  ),
                  child: Text(
                    user?.displayName?.toUpperCase() ?? 'Loading',
                    style: TextStyle(
                      fontFamily: 'Teko',
                      fontSize: 28,
                      color: kLightGray,
                    ),
                  ),
                ),
                StatBar(),
                // Expanded(
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(vertical: kHeight(context) * .03),
                //     // child: Container(
                //     //   // height: kHeight(context) * .15,
                //     //   child: ,
                //     //   decoration: BoxDecoration(
                //     //     color: kDarkGray,
                //     //     borderRadius: BorderRadius.circular(5),
                //     //   ),
                //     // ),
                //     child: Chart(),
                //   ),
                // ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      // vertical: kWidth(context) * .03,
                      ),
                  child: Text(
                    'MOTIVATION',
                    style: TextStyle(
                      fontFamily: 'Teko',
                      fontSize: 28,
                      color: kLightGray,
                    ),
                  ),
                ),
                QuoteWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
