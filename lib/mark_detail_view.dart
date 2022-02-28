import 'package:date_time_picker/date_time_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'mark.dart';

class MarkDetailView extends StatefulWidget {
  final ViewType viewType;

  const MarkDetailView({Key? key, required this.viewType}) : super(key: key);

  @override
  State<MarkDetailView> createState() => _MarkDetailViewState();
}

class _MarkDetailViewState extends State<MarkDetailView> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _subjectCtrl = TextEditingController();
  ValidMark? _selectedMark;
  ValidExamType? _selectedExamType;
  final TextEditingController _dateCtrl =
      TextEditingController(text: DateTime.now().toString());
  final TextEditingController _notesCtrl = TextEditingController();
  bool _buttonVisibility = true;
  bool _readOnly = false;
  Mark? _mark;

  @override
  void dispose() {
    _subjectCtrl.dispose();
    _dateCtrl.dispose();
    super.dispose();
  }

  void setDataFields(Mark mark) {
    _subjectCtrl.text = mark.subject;
    _selectedMark = mark.mark;
    _selectedExamType = mark.exam;
    _dateCtrl.text = mark.date;
    _notesCtrl.text = mark.notes;
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.viewType) {
      case ViewType.add:
        break;
      case ViewType.edit:
        Mark mark = ModalRoute.of(context)?.settings.arguments as Mark;
        _mark = mark;
        setDataFields(mark);
        break;
      case ViewType.show:
        Mark mark = ModalRoute.of(context)?.settings.arguments as Mark;
        _mark = mark;
        setDataFields(mark);
        _buttonVisibility = false;
        _readOnly = true;
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.viewType.viewTypeName + " mark"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    enabled: !_readOnly,
                    controller: _subjectCtrl,
                    decoration: const InputDecoration(
                      hintText: "Subject",
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter a subject";
                      }
                      return null;
                    },
                  ),
                  IgnorePointer(
                    ignoring: _readOnly,
                    child: DropdownButtonFormField<ValidMark>(
                      hint: const Text("Mark"),
                      items: List.generate(
                        ValidMark.values.length,
                        (index) => DropdownMenuItem(
                          child: Text(ValidMark.values[index].markName),
                          value: ValidMark.values[index],
                        ),
                      ),
                      value: _selectedMark,
                      onChanged: (value) {
                        _selectedMark = value!;
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Please select your mark";
                        }
                        return null;
                      },
                    ),
                  ),
                  IgnorePointer(
                    ignoring: _readOnly,
                    child: DropdownButtonFormField<ValidExamType>(
                      hint: const Text("Exam type"),
                      items: List.generate(
                        ValidExamType.values.length,
                        (index) => DropdownMenuItem(
                          child: Text(ValidExamType.values[index].examName),
                          value: ValidExamType.values[index],
                        ),
                      ),
                      value: _selectedExamType,
                      onChanged: (value) {
                        _selectedExamType = value!;
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Please select the exam type";
                        }
                        return null;
                      },
                    ),
                  ),
                  DateTimePicker(
                    enabled: !_readOnly,
                    type: DateTimePickerType.date,
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    initialDate: DateTime.now(),
                    icon: const Icon(Icons.date_range),
                    dateHintText: "Date",
                    dateMask: "dd.MM.yyyy",
                    controller: _dateCtrl,
                  ),
                  TextFormField(
                    enabled: !_readOnly,
                    controller: _notesCtrl,
                    decoration: const InputDecoration(
                      hintText: "Notes",
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 4,
                  ),
                  Visibility(
                    visible: _buttonVisibility,
                    child: Row(
                      children: [
                        const Spacer(
                          flex: 3,
                        ),
                        Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, null);
                                },
                                child: const Text("cancel").tr(),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    switch (widget.viewType) {
                                      case ViewType.add:
                                        Navigator.pop(
                                          context,
                                          Mark(
                                            subject: _subjectCtrl.text,
                                            mark: _selectedMark!,
                                            exam: _selectedExamType!,
                                            date: _dateCtrl.text,
                                            notes: _notesCtrl.text,
                                          ),
                                        );
                                        break;
                                      case ViewType.edit:
                                        _mark?.subject = _subjectCtrl.text;
                                        _mark?.mark = _selectedMark!;
                                        _mark?.exam = _selectedExamType!;
                                        _mark?.date = _dateCtrl.text;
                                        _mark?.notes = _notesCtrl.text;

                                        Navigator.pop(context, _mark);
                                        break;
                                      case ViewType.show:
                                        Navigator.pop(context);
                                        break;
                                    }
                                  }
                                },
                                child: const Text("save").tr(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !_buttonVisibility,
                    child: TextButton(
                      child: const Text("Edit"),
                      onPressed: () async {
                        final mark = await Navigator.of(context)
                            .pushNamed("/editMark", arguments: _mark);
                        if (mark != null) {
                          _mark = mark as Mark;
                          setState(() {
                            setDataFields(mark);
                          });
                          marksViewKey.currentState!.updateMark(mark);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
