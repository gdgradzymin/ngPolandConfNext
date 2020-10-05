import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/providers/contentful.dart';
import 'package:ng_poland_conf_next/providers/selectedPage.dart';
import 'package:ng_poland_conf_next/providers/themeManager.dart';
import 'package:ng_poland_conf_next/screens/about.dart';
import 'package:ng_poland_conf_next/screens/home.dart';
import 'package:ng_poland_conf_next/screens/info.dart';
import 'package:ng_poland_conf_next/screens/ngGirls.dart';
import 'package:ng_poland_conf_next/screens/schedule.dart';
import 'package:ng_poland_conf_next/screens/speakerDetails.dart';
import 'package:ng_poland_conf_next/screens/speakers.dart';
import 'package:ng_poland_conf_next/screens/workShops.dart';
import 'package:provider/provider.dart';
import 'package:flutter_config/flutter_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterConfig.loadEnvVariables();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeNotifier themeNotifier = ThemeNotifier();

  void getStatusDarkTheme() async {
    themeNotifier.darkTheme =
        await themeNotifier.darkThemePreferences.getStatusDarkTheme();
  }

  @override
  void initState() {
    getStatusDarkTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => themeNotifier,
        ),
        ChangeNotifierProvider(
          create: (_) => SelectedPage(),
        ),
        ChangeNotifierProvider(
          create: (_) => ContentfulService(),
        ),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, _) {
          return MaterialApp(
            title: 'ngPolandConf 2020',
            theme: ThemeData(
              brightness: Brightness.light,
              accentColor: Color.fromRGBO(255, 0, 122, 1),
              primaryColor: Color.fromRGBO(59, 29, 130, 1),
              canvasColor: Colors.white,
              textTheme: TextTheme(
                headline1: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              accentColor: Color.fromRGBO(255, 0, 122, 1),
              primaryColor: Color.fromRGBO(59, 29, 130, 1),
              textTheme: TextTheme(
                headline1: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            themeMode: theme.darkTheme ? ThemeMode.dark : ThemeMode.light,
            initialRoute: '/',
            routes: {
              // When navigating to the "/" route, build the FirstScreen widget.
              '/': (context) => Home(title: 'ngPolandConf'),
              // When navigating to the "/second" route, build the SecondScreen widget.
              '/Schedule': (context) => Schedule(title: 'Schedule - NG Poland'),
              '/WorkShops': (context) => WorkShops(title: 'WorkShops'),
              '/NgGirls': (context) => NgGirls(title: 'ngGirls'),
              '/Speakers': (context) => Speakers(title: 'Speakers'),
              '/Info': (context) => Info(title: 'Info'),
              '/About': (context) => About(title: 'About'),
              '/SpeakerDetails': (context) => SpeakerDetails(),
            },
          );
        },
      ),
    );
  }
}
