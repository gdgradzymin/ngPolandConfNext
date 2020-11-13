import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ngPolandConf/models/contentful.dart';
import 'package:ngPolandConf/providers/connection.dart';
import 'package:ngPolandConf/providers/eventItems.dart';
import 'package:ngPolandConf/providers/infoItems.dart';
import 'package:ngPolandConf/providers/speakers.dart';
import 'package:ngPolandConf/providers/workShops.dart';
import 'package:ngPolandConf/screens/presenter.dart';
import 'package:ngPolandConf/services/contentful.dart';
import 'package:ngPolandConf/providers/selectedPage.dart';
import 'package:ngPolandConf/providers/ngGirls.dart';
import 'package:ngPolandConf/providers/themeManager.dart';
import 'package:ngPolandConf/screens/about.dart';
import 'package:ngPolandConf/screens/newHome.dart';
import 'package:ngPolandConf/screens/info.dart';
import 'package:ngPolandConf/screens/ngGirls.dart';
import 'package:ngPolandConf/screens/schedule.dart';
import 'package:ngPolandConf/screens/speakers.dart';
import 'package:ngPolandConf/screens/workshops.dart';
import 'package:ngPolandConf/shared/widgets/slideRoutes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

GetIt locator = GetIt.instance;

void setupSingletons() async {
  locator.registerLazySingleton<ContentfulService>(() => ContentfulService());
}

Future main() async {
  await DotEnv().load('.env');
  setupSingletons();

  WidgetsFlutterBinding.ensureInitialized();

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

  void _fetchAllData({BuildContext context, bool reload = false}) {
    InfoItemsProvider _info =
        Provider.of<InfoItemsProvider>(context, listen: false);

    EventItemsProvider _events =
        Provider.of<EventItemsProvider>(context, listen: false);

    NgGirlsProvider _ngGirls =
        Provider.of<NgGirlsProvider>(context, listen: false);

    WorkshopsProvider _workshops =
        Provider.of<WorkshopsProvider>(context, listen: false);

    SpeakersProvider _speakers =
        Provider.of<SpeakersProvider>(context, listen: false);

    if (_info.infoItems.isEmpty) {
      _info.fetchData(howMany: 999, reload: reload);
    }

    if (_events.eventItems.isEmpty) {
      _events.fetchData(howMany: 999, reload: reload);
      _events.selectedItems = EventItemType.JSPOLAND;
      _events.fetchData(howMany: 999, reload: reload);
      _events.selectedItems = EventItemType.NGPOLAND;
    }

    if (_ngGirls.data == null) {
      _ngGirls.fetchData(myId: 'ng-girls-workshops', reload: reload);
    }

    if (_workshops.workshopItems.isEmpty) {
      _workshops.fetchData(howMany: 999, reload: reload);

      _workshops.selectedItems = EventItemType.JSPOLAND;

      _workshops.fetchData(howMany: 999, reload: reload);

      _workshops.selectedItems = EventItemType.NGPOLAND;
    }

    if (_speakers.speakers.isEmpty) {
      _speakers.fetchData(howMany: 999, reload: reload);
    }
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

              // if data is empty - will download all data
              _fetchAllData(context: context, reload: true);
            } else if (result == ConnectivityResult.mobile) {
              Provider.of<Connection>(context, listen: false).viewedSnackBar =
                  0;
              Provider.of<Connection>(context, listen: false).status = true;

              // if data is empty - will download all data
              _fetchAllData(context: context, reload: true);
            } else {
              Provider.of<Connection>(context, listen: false).status = false;
              _fetchAllData(context: context, reload: true);
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
                  bodyText1: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.8)),
                ),
                dividerTheme: const DividerThemeData(
                  color: Color.fromRGBO(255, 0, 122, 0.3),
                )),
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
                dividerTheme: const DividerThemeData(
                  color: Color.fromRGBO(255, 0, 122, 0.4),
                )),
            themeMode: theme.darkTheme ? ThemeMode.dark : ThemeMode.light,
            initialRoute: '/',
            onGenerateRoute: (RouteSettings settings) {
              var defaultRoutes = {
                '/': (dynamic context) => Home(title: 'ngPolandConf'),
                '/NgGirls': (dynamic context) => NgGirls(title: 'ngGirls'),
                '/Speakers': (dynamic context) => Speakers(title: 'Speakers'),
                '/Info': (dynamic context) => Info(title: 'Info'),
                '/About': (dynamic context) => About(title: 'About'),
              };

              switch (settings.name) {
                case '/Presenter':
                  {
                    final Map<String, Object> _data =
                        settings.arguments as Map<String, Object>;

                    final Speaker _speaker = _data['speaker'] as Speaker;

                    return PresenterRoute(
                      page: Presenter(
                        data: _data,
                        speaker: _speaker,
                      ),
                    );
                  }
                  break;

                case '/Workshops':
                  {
                    final Map<String, Object> _data =
                        settings.arguments as Map<String, Object>;

                    final String _route = _data['route'] as String;

                    return _route == 'scale'
                        ? ScaleRoute(
                            page: Workshops(title: 'Workshops'),
                          )
                        : LeftRoute(
                            page: Workshops(title: 'Workshops'),
                          );
                  }
                  break;

                case '/Schedule':
                  {
                    final Map<String, Object> _data =
                        settings.arguments as Map<String, Object>;

                    final String _route = _data['route'] as String;

                    return _route == 'scale'
                        ? ScaleRoute(
                            page: Schedule(title: 'Schedule'),
                          )
                        : LeftRoute(
                            page: Schedule(title: 'Schedule'),
                          );
                  }
                  break;

                default:
                  {
                    return MaterialPageRoute<dynamic>(
                      builder: (context) =>
                          defaultRoutes[settings.name](context),
                      settings: settings,
                    );
                  }
                  break;
              }
            },
          );
        },
      ),
    );
  }
}
