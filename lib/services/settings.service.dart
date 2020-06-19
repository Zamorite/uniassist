import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniassist/utils/constants.dart';
import 'package:uniassist/utils/theme.dart';

class SettingsService {
  isLight(BuildContext context) {
    return Provider.of<ThemeChanger>(context).getTheme() == kLightTheme;
  }

  toggleTheme(
    BuildContext context,
    value,
  ) {
    Provider.of<ThemeChanger>(context, listen: false)
        .setTheme(value ? kLightTheme : kDarkTheme);
  }
}
