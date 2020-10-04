import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/widgets/drawer.dart';

class Speakers extends StatelessWidget {
  static const routeName = '/Speakers';

  final String title;

  Speakers({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      drawer: DrawerNg(),
      body: Center(
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(16),
                  onTap: () {},
                  leading: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                    child: Image.asset(
                        'assets/images/person.png'), // speaker.photo != null ? speaker.photo : image.asset('assets/images/person.png'),
                  ),
                  title: Text('speakerName$index'), // speaker.name
                  subtitle: Text('speakerRole$index'), // speaker.role
                ),
                Divider(
                  height: 0,
                  color: Theme.of(context).accentColor,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
