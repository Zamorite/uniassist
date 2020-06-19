import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniassist/services/settings.service.dart';
import 'package:uniassist/utils/constants.dart';
import 'package:uniassist/utils/service.locator.dart';
import 'package:uniassist/utils/theme.dart';
import 'package:uniassist/widgets/default.scaffold.dart';
import 'package:uniassist/widgets/setting.tile.dart';

class SettingsScreen extends StatelessWidget {
  SettingsService settingService = locator.get<SettingsService>();

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return DefaultScaffold(
      title: 'SETTINGS',
      // icon: Icon(
      //   Fontisto.search,
      //   color: kLightGray,
      //   size: 24,
      // ),
      hPadding: false,
      action: () => null,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          // FlatButton(
          //   child: Text('Dark Theme'),
          //   onPressed: () => _themeChanger.setTheme(
          //     kDarkTheme,
          //   ),
          // ),
          // FlatButton(
          //   child: Text('Light Theme'),
          //   onPressed: () => _themeChanger.setTheme(
          //     ThemeData.light(),
          //   ),
          // ),
          ListBody(
            children: <Widget>[
              SettingTile(
                title: 'Use Light Theme',
                trailing: Switch(
                  value: settingService.isLight(context),
                  onChanged: (value) =>
                      settingService.toggleTheme(context, value),
                ),
              ),
            ],
          )
        ],
      ),
      fab: FloatingActionButton(onPressed: null),
    );
  }
}
