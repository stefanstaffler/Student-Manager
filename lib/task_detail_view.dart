import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'generated/l10n.dart';
import 'task.dart';

class TaskDetailView extends StatefulWidget {
  final ViewType viewType;

  const TaskDetailView({Key? key, required this.viewType}) : super(key: key);

  @override
  State<TaskDetailView> createState() => _TaskDetailViewState();
}

class _TaskDetailViewState extends State<TaskDetailView> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _subjectCtrl = TextEditingController();
  final TextEditingController _taskCtrl = TextEditingController();
  final TextEditingController _dateCtrl =
      TextEditingController(text: DateTime.now().toString());
  ValidTaskState? _selectedTaskState;
  bool _buttonVisibility = true;
  bool _readOnly = false;
  Task? _task;

  @override
  void dispose() {
    _subjectCtrl.dispose();
    _taskCtrl.dispose();
    _dateCtrl.dispose();
    super.dispose();
  }

  void setDataFields(Task task) {
    _subjectCtrl.text = task.subject;
    _taskCtrl.text = task.task;
    _dateCtrl.text = task.date;
    _selectedTaskState = task.taskState;
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.viewType) {
      case ViewType.add:
        break;
      case ViewType.edit:
        Task task = ModalRoute.of(context)?.settings.arguments as Task;
        _task = task;
        setState(() {
          setDataFields(task);
        });
        break;
      case ViewType.show:
        Task task = ModalRoute.of(context)?.settings.arguments as Task;
        _task = task;
        setState(() {
          setDataFields(task);
        });
        _buttonVisibility = false;
        _readOnly = true;
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.viewType.viewTypeName + " task"),
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
                  TextFormField(
                    enabled: !_readOnly,
                    controller: _taskCtrl,
                    decoration: const InputDecoration(
                      hintText: "Task",
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 4,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter a task";
                      }
                      return null;
                    },
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
                  IgnorePointer(
                    ignoring: _readOnly,
                    child: DropdownButtonFormField<ValidTaskState>(
                      hint: const Text("Task state"),
                      items: List.generate(
                        ValidTaskState.values.length,
                        (index) => DropdownMenuItem(
                          child: Text(ValidTaskState.values[index].stateName),
                          value: ValidTaskState.values[index],
                        ),
                      ),
                      value: _selectedTaskState,
                      onChanged: (value) {
                        _selectedTaskState = value!;
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Please select the task state";
                        }
                        return null;
                      },
                    ),
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
                                child: Text(S().cancel),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    switch (widget.viewType) {
                                      case ViewType.add:
                                        Navigator.pop(
                                          context,
                                          Task(
                                            subject: _subjectCtrl.text,
                                            task: _taskCtrl.text,
                                            date: _dateCtrl.text,
                                            taskState: _selectedTaskState!,
                                          ),
                                        );
                                        break;
                                      case ViewType.edit:
                                        _task?.subject = _subjectCtrl.text;
                                        _task?.task = _taskCtrl.text;
                                        _task?.date = _dateCtrl.text;
                                        _task?.taskState = _selectedTaskState!;

                                        Navigator.pop(context, _task);
                                        break;
                                      case ViewType.show:
                                        Navigator.pop(context);
                                        break;
                                    }
                                  }
                                },
                                child: Text(S().save),
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
                        final task = await Navigator.of(context)
                            .pushNamed("/editTask", arguments: _task);
                        if (task != null) {
                          _task = task as Task;
                          setState(() {
                            setDataFields(task);
                          });
                          tasksViewKey.currentState!.updateTask(task);
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
