import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/providers/themeManager.dart';
import 'package:ng_poland_conf_next/widgets/drawer.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider(create: (_) => ThemeNotifier(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, child) {
        return MaterialApp(
          title: 'ngPolandConf',
          theme: ThemeData(
            brightness: Brightness.light,
            accentColor: Color.fromRGBO(231, 1, 94, 1),
            primaryColor: Color.fromRGBO(0, 90, 135, 1),
            canvasColor: Colors.white,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.lightBlue,
          ),
          themeMode: theme.getMode,
          home: child,
        );
      },
      child: MyHomePage(title: 'ngPolandConf'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: DrawerNg(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hi ngPoland :)',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: Provider.of<ThemeNotifier>(context).changeTheme,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
