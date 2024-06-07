import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/models/task_model.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context);
    for (var task in tasks) {
      print(task.title);
      print(task.description);
      print(task.isCompleted);
    }
    return Container();
  }
}
