import 'package:flutter/material.dart';
import 'package:ngPolandConf/models/contentful.dart';
import 'package:ngPolandConf/providers/ngGirls.dart';
import 'package:ngPolandConf/shared/widgets/emptyListInformation.dart';
import 'package:provider/provider.dart';

class NgGirlsContent extends StatelessWidget {
  NgGirlsContent(
    this.refreshIndicatorKey,
  );

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

  bool _loadingData = false;

  @override
  Widget build(BuildContext context) {
    SimpleContent _simpleContent =
        Provider.of<NgGirlsProvider>(context).data ?? null;

    if (_simpleContent == null && !_loadingData) {
      _loadingData = true;

      Provider.of<NgGirlsProvider>(context, listen: false)
          .fetchData(myId: 'ng-girls-workshops', reload: true);
    }
    return ListView(
      children: [
        _simpleContent == null
            ? EmptyListInformation()
            : Text(_simpleContent == null ? '' : _simpleContent.text,
                style: Theme.of(context).textTheme.bodyText2),
      ],
    );
  }
}
