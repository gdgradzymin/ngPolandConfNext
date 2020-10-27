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
            Icon(
              Icons.update,
              size: 85,
              color: Theme.of(context).accentColor.withOpacity(0.5),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                'We\'re in the process of updating this information, please check again later.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      //  color: Theme.of(context).primaryTextTheme.,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
