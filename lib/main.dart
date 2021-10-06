import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:ngPolandConf/models/contentful.dart';
import 'package:ngPolandConf/providers/connection.dart';
import 'package:ngPolandConf/providers/eventItems.dart';
import 'package:ngPolandConf/providers/infoItems.dart';
import 'package:ngPolandConf/providers/ngGirls.dart';
import 'package:ngPolandConf/providers/selectedPage.dart';
import 'package:ngPolandConf/providers/speakers.dart';
import 'package:ngPolandConf/providers/themeManager.dart';
import 'package:ngPolandConf/providers/workShops.dart';
import 'package:ngPolandConf/screens/about.dart';
import 'package:ngPolandConf/screens/info.dart';
import 'package:ngPolandConf/screens/newHome.dart';
import 'package:ngPolandConf/screens/ngGirls.dart';
import 'package:ngPolandConf/screens/presenter.dart';
import 'package:ngPolandConf/screens/schedule.dart';
import 'package:ngPolandConf/screens/speakers.dart';
import 'package:ngPolandConf/screens/workshops.dart';
import 'package:ngPolandConf/services/contentful.dart';
import 'package:ngPolandConf/shared/widgets/slideRoutes.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

GetIt locator = GetIt.instance;

void setupSingletons() async {
  locator.registerLazySingleton<ContentfulService>(() => ContentfulService());
}

Future main() async {
  await dotenv.load(fileName: '.env');
  setupSingletons();

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final PublishSubject<ConnectivityResult> connectionStatus =
      PublishSubject<ConnectivityResult>();

  Connectivity connectivity;

  ThemeNotifier themeNotifier = ThemeNotifier();

  BuildContext ctx;

  void getStatusDarkTheme() async {
    themeNotifier.darkTheme =
        await themeNotifier.darkThemePreferences.getStatusDarkTheme();
  }

  @override
  void initState() {
    getStatusDarkTheme();
    super.initState();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      connectionStatus.add(result);
    });

    connectionStatus.stream
        .debounceTime(const Duration(
            seconds: 3)) // ignore quick changes like cell -> wifi
        .distinct((a, b) {
      // only different states
      return a.toString() == b.toString();
    }).listen((ConnectivityResult r) {
      switch (r) {
        case ConnectivityResult.wifi:
        case ConnectivityResult.mobile:
          _fetchAllData(context: ctx, reload: true);
          Provider.of<Connection>(ctx, listen: false).status = true;
          break;
        default:
          _fetchAllData(context: ctx, reload: false);
          Provider.of<Connection>(ctx, listen: false).status = false;
          break;
      }
    });
  }

  Future<void> initConnectivity(BuildContext ctx) async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    if (!Provider.of<Connection>(ctx, listen: false).initialFetch) {
      switch (result) {
        case ConnectivityResult.wifi:
        case ConnectivityResult.mobile:
          _fetchAllData(context: ctx, reload: true);
          Provider.of<Connection>(ctx, listen: false).status = true;
          break;
        default:
          _fetchAllData(context: ctx, reload: false);
          Provider.of<Connection>(ctx, listen: false).status = false;
          break;
      }
    }
    Provider.of<Connection>(ctx, listen: false).initialFetch = true;
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
    connectionStatus.close();
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

    _info.fetchData(howMany: 999, reload: reload);

    _events.selectedItems = EventItemType.JSPOLAND;
    _events.fetchData(howMany: 999, reload: reload);
    _events.selectedItems = EventItemType.NGPOLAND;
    _events.fetchData(howMany: 999, reload: reload);

    _ngGirls.fetchData(myId: 'ng-girls-workshops', reload: reload);

    _workshops.selectedItems = EventItemType.JSPOLAND;
    _workshops.fetchData(howMany: 999, reload: reload);
    _workshops.selectedItems = EventItemType.NGPOLAND;
    _workshops.fetchData(howMany: 999, reload: reload);

    _speakers.fetchData(howMany: 999, reload: reload);
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
          ctx = context;
          initConnectivity(context);
          return MaterialApp(
            title: 'ngPolandConf 2020',
            theme: ThemeData(
                // brightness: Brightness.light,
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
                ),
                colorScheme: ColorScheme.fromSwatch().copyWith(
                    secondary: const Color.fromRGBO(255, 0, 122, 1),
                    brightness: Brightness.light)),
            darkTheme: ThemeData(
                //brightness: Brightness.dark,
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
                ),
                colorScheme: ColorScheme.fromSwatch().copyWith(
                    secondary: const Color.fromRGBO(233, 30, 99, 1),
                    brightness: Brightness.dark)),
            themeMode: theme.darkTheme ? ThemeMode.dark : ThemeMode.light,
            initialRoute: '/',
            onGenerateRoute: (RouteSettings settings) {
              var defaultRoutes = {
                '/': (dynamic context) => const Home(title: 'ngPolandConf'),
                '/NgGirls': (dynamic context) => NgGirls(title: 'ngGirls'),
                '/Speakers': (dynamic context) => Speakers(title: 'Speakers'),
                '/Info': (dynamic context) => const Info(title: 'Info'),
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
                            page: const Workshops(title: 'Workshops'),
                          )
                        : LeftRoute(
                            page: const Workshops(title: 'Workshops'),
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
