import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ng_poland_conf_next/providers/connection.dart';
import 'package:ng_poland_conf_next/providers/eventItems.dart';
import 'package:ng_poland_conf_next/providers/infoItems.dart';
import 'package:ng_poland_conf_next/providers/speakers.dart';
import 'package:ng_poland_conf_next/providers/workShops.dart';
import 'package:ng_poland_conf_next/screens/presenter.dart';
import 'package:ng_poland_conf_next/services/contentful.dart';
import 'package:ng_poland_conf_next/providers/selectedPage.dart';
import 'package:ng_poland_conf_next/providers/ngGirls.dart';
import 'package:ng_poland_conf_next/providers/themeManager.dart';
import 'package:ng_poland_conf_next/screens/about.dart';
import 'package:ng_poland_conf_next/screens/newHome.dart';
import 'package:ng_poland_conf_next/screens/info.dart';
import 'package:ng_poland_conf_next/screens/ngGirls.dart';
import 'package:ng_poland_conf_next/screens/schedule.dart';
import 'package:ng_poland_conf_next/screens/speakers.dart';
import 'package:ng_poland_conf_next/screens/workshops.dart';
import 'package:provider/provider.dart';
import 'package:flutter_config/flutter_config.dart';

GetIt locator = GetIt.instance;

void setupSingletons() async {
  locator.registerLazySingleton<ContentfulService>(() => ContentfulService());
}

void main() async {
  setupSingletons();

  WidgetsFlutterBinding.ensureInitialized();

  await FlutterConfig.loadEnvVariables();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Connectivity connectivity;

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
          create: (_) => InfoItemsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EventItemsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NgGirlsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WorkshopsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SpeakersProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => Connection(),
        ),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, _) {
          // Checking Status internet
          connectivity = Connectivity();
          connectivity.onConnectivityChanged
              .listen((ConnectivityResult result) {
            if (result == ConnectivityResult.wifi) {
              Provider.of<Connection>(context, listen: false).viewedSnackBar =
                  0;
              Provider.of<Connection>(context, listen: false).status = true;
            } else if (result == ConnectivityResult.mobile) {
              Provider.of<Connection>(context, listen: false).viewedSnackBar =
                  0;
              Provider.of<Connection>(context, listen: false).status = true;
            } else {
              Provider.of<Connection>(context, listen: false).status = false;
            }
          });
          //

          return MaterialApp(
            title: 'ngPolandConf 2020',
            theme: ThemeData(
              brightness: Brightness.light,
              accentColor: const Color.fromRGBO(255, 0, 122, 1),
              primaryColor: const Color.fromRGBO(59, 29, 130, 1),
              canvasColor: Colors.white,
              textTheme: const TextTheme(
                  headline1: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  headline2: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  headline3: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 0, 0, 0.8)),
                  bodyText1: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.8))),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              accentColor: const Color.fromRGBO(233, 30, 99, 1),
              primaryColor: const Color.fromRGBO(59, 29, 130, 1),
              textTheme: const TextTheme(
                  headline1: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  headline2: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  headline3: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 255, 255, 0.9)),
                  bodyText1:
                      TextStyle(color: Color.fromRGBO(255, 255, 255, 0.9))),
            ),
            themeMode: theme.darkTheme ? ThemeMode.dark : ThemeMode.light,
            initialRoute: '/',
            routes: {
              // When navigating to the "/" route, build the FirstScreen widget.
              '/': (context) => Home(title: 'ngPolandConf'),
              // When navigating to the "/second" route, build the SecondScreen widget.
              '/Schedule': (context) =>
                  const Schedule(title: 'Schedule - NG Poland'),
              '/Workshops': (context) => Workshops(title: 'Workshops'),
              '/NgGirls': (context) => const NgGirls(title: 'ngGirls'),
              '/Speakers': (context) => Speakers(title: 'Speakers'),
              '/Info': (context) => Info(title: 'Info'),
              '/About': (context) => About(title: 'About'),
              '/Presenter': (context) => Presenter(),
            },
          );
        },
      ),
    );
  }
}
