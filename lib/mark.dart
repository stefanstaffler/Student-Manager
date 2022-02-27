import 'package:flutter/material.dart';

import 'constants.dart';

class Mark {
  int? id;
  String subject;
  ValidMark mark;
  ValidExamType exam;
  String date;
  String notes;

  Mark({
    Key? key,
    this.id,
    required this.subject,
    required this.mark,
    required this.exam,
    required this.date,
    required this.notes,
  });

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "subject": subject,
      "mark": mark.value,
      "exam": exam.acronym,
      "date": date,
      "notes": notes,
    };
  }

  static Mark fromMap(Map<String, Object?> map) {
    return Mark(
      id: map["id"] as int,
      subject: map["subject"].toString(),
      mark: ValidMark.values
          .singleWhere((element) => element.value == (map["mark"] as int)),
      exam: ValidExamType.values.singleWhere(
        (element) => element.acronym == map["exam"].toString(),
        orElse: () => ValidExamType.other,
      ),
      date: map["date"].toString(),
      notes: map["notes"].toString(),
    );
  }
}
