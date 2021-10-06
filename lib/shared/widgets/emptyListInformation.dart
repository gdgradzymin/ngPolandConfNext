import 'package:flutter/material.dart';

class EmptyListInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.update,
                size: 85,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  'Sorry, no results returned. Please check again later.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
