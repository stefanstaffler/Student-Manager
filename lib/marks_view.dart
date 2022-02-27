import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'database.dart';
import 'generated/l10n.dart';
import 'mark.dart';
import 'mark_card.dart';

class MarksView extends StatefulWidget {
  const MarksView({Key? key}) : super(key: key);

  @override
  State<MarksView> createState() => MarksViewState();
}

class MarksViewState extends State<MarksView> {
  final List<Mark> _markList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();

    loadMarks();
  }

  void loadMarks() {
    StudentManagerDb().database.then((db) async {
      if (db != null) {
        List<Map<String, Object?>> marksMaps = await db.query("marks");
        List<Mark> mList =
            marksMaps.map((e) => Mark.fromMap(e)).toList(growable: true);
        _addMarksFromDb(mList);
      }
    });
  }

  void _addMarksFromDb(List<Mark> marks) {
    setState(() {
      _markList.addAll(marks);
    });
  }

  void addMark(Mark mark) async {
    Database? db = await StudentManagerDb().database;
    int? id = await db?.insert("marks", mark.toMap());

    if (id != null) {
      mark.id = id;
    }

    setState(() {
      _markList.add(mark);
    });
  }

  void addMarkAt(Mark mark, int index) async {
    Database? db = await StudentManagerDb().database;
    int? id = await db?.insert("marks", mark.toMap());

    if (id != null) {
      mark.id = id;
    }

    setState(() {
      _markList.insert(index, mark);
    });
  }

  void removeMark(int index) async {
    Database? db = await StudentManagerDb().database;
    await db
        ?.delete("marks", where: "id = ?", whereArgs: [_markList[index].id]);
    setState(() {
      _markList.removeAt(index);
    });
  }

  void updateMark(Mark mark) async {
    Database? db = await StudentManagerDb().database;
    await db
        ?.update("marks", mark.toMap(), where: "id = ?", whereArgs: [mark.id]);
    setState(() {
      int index = _markList.indexOf(mark);
      _markList.remove(mark);
      _markList.insert(index, mark);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S().menu_marks,
          style: Theme.of(context).textTheme.headline1,
          textAlign: TextAlign.center,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _markList.length,
            itemBuilder: (context, index) {
              return MarkCard(
                mark: _markList[index],
                dismissDirectionCallback: (direction) {
                  Mark markItem = _markList[index];

                  removeMark(index);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text("Mark deleted"),
                    action: SnackBarAction(
                      label: S().back,
                      onPressed: () {
                        addMarkAt(markItem, index);
                      },
                    ),
                  ));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
