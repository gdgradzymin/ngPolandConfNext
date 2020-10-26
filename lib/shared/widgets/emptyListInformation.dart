import 'package:flutter/material.dart';

class EmptyListInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                'We\'re in the process of updating this information, please check again later.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 25,
                    ),
              ),
            ),
            Icon(
              Icons.update,
              size: 65,
              color: Theme.of(context).accentColor.withOpacity(0.5),
            )
          ],
        )
      ],
    );
  }
}
