import 'package:flutter/material.dart';

import 'constants.dart';
import 'mark.dart';

class MarkCard extends StatelessWidget {
  final Mark mark;
  final DismissDirectionCallback dismissDirectionCallback;

  const MarkCard(
      {Key? key, required this.mark, required this.dismissDirectionCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(mark),
      child: GestureDetector(
        child: Card(
          child: ListTile(
            title: Text(mark.subject),
            subtitle: Text(mark.mark.markName),
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed("/showMark", arguments: mark);
        },
      ),
      onDismissed: dismissDirectionCallback,
      direction: DismissDirection.endToStart,
    );
  }
}
