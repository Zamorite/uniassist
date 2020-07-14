import 'package:flutter/material.dart';

const Color kOrange = Color(0xFFFF5500);
const Color kLightGray = Color(0xFF8E8E93);
const Color kDarkGray = Color(0xFF242424);

ThemeData kDarkTheme = ThemeData(
  // Define the default brightness and colors.
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  primaryColor: Color(0xFF242424),
  accentColor: Color(0xFFFF5500),
  cardColor: Color(0xFF242424),
  cursorColor: kLightGray,
  textSelectionHandleColor: kOrange,

  colorScheme: ColorScheme.dark(
    primary: kOrange,
    onPrimary: Colors.white,
    surface: kDarkGray,
    onSurface: kLightGray,
    secondary: kOrange,
    onSecondary: Colors.white,
  ),

  // Define the default font family.
  fontFamily: 'Roboto',

  // Define the default TextTheme. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  // textTheme: TextTheme(
  //   headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
  //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  // ),
);

ThemeData kLightTheme = ThemeData(
  // Define the default brightness and colors.
  primaryColor: Color(0xFF242424),
  accentColor: Color(0xFFFF5500),
  cardColor: Color(0xFF242424),

  colorScheme: ColorScheme.dark(
    primary: Colors.deepPurple,
    onPrimary: Colors.white,
    surface: Colors.pink,
    onSurface: Colors.yellow,
  ),
  // cal

  // Define the default font family.
  fontFamily: 'Roboto',

  // Define the default TextTheme. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  // textTheme: TextTheme(
  //   headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
  //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  // ),
);

double kHeight(BuildContext context) => MediaQuery.of(context).size.height;
double kWidth(BuildContext context) => MediaQuery.of(context).size.width;

const kH1 = TextStyle(
  fontFamily: 'Teko',
  fontSize: 48,
);
const kActionTextStyle = TextStyle(
  fontFamily: 'Teko',
  fontSize: 24,
);
const kTaskListTextStyle = TextStyle(
  // fontFamily: 'Teko',
  fontSize: 16,
);

const kTaskTypes = ['Assignment', 'Project'];

const String kExitWarning = 'Press back again to exit 🚪';

const kQuotes = [
  [
    0,
    'Concentrate all your thoughts upon the work at hand. The sun’s rays do not burn until brought to a focus.',
    'Alexander Graham Bell',
  ],
  [
    1,
    'We are what we repeatedly do. Excellence, then, is not an act but a habit.',
    'Will Durant',
  ],
  [
    2,
    'The successful warrior is the average man, with laser-like focus.',
    'Bruce Lee',
  ],
  [
    3,
    'Concentration can be cultivated. One can learn to exercise willpower, discipline one’s body and train one’s mind.',
    'Anil Ambani',
  ],
  [
    4,
    'You don’t get results by focusing on results. You get results by focusing on the actions that produce results.',
    'Mike Hawkins',
  ],
  [
    5,
    'A clear vision, backed by definite plans, gives you a tremendous feeling of confidence and personal power.',
    'Brian Tracy',
  ],
  [
    6,
    'My success, part of it certainly, is that I have focused in on a few things.',
    'Bill Gates',
  ],
  [
    7,
    'You only have to do a very few things right in your life so long as you don’t do too many things wrong.',
    'Warren Buffet',
  ],
  [
    8,
    'When walking, walk. When eating, eat.',
    'Zen proverb',
  ],
  [
    9,
    'Discovering what you really want saves you endless confusion and wasted energy.',
    'Stuart Wilde',
  ],
  [
    10,
    'Focus 90% of your time on solutions and only 10% of your time on problems.',
    'Anthony J. D’Angelo',
  ],
  [
    11,
    'Focus is a matter of deciding what things you’re not going to do.',
    'John Carmack',
  ],
  [
    12,
    'I do what I do, and I do it well, and focus and take it one moment at a time.',
    'James Caviezel',
  ],
];
