import 'package:flutter/material.dart';

import 'mark.dart';
import 'marks_view.dart';

class AddMarkButton extends StatelessWidget {
  const AddMarkButton({Key? key, required this.marksViewKey}) : super(key: key);

  final GlobalKey<MarksViewState> marksViewKey;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () async {
        final mark = await Navigator.pushNamed(context, "/addMark");
        if (mark != null) {
          marksViewKey.currentState?.addMark(mark as Mark);
        }
      },
    );
  }
}
