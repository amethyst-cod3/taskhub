import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/home/task_tile.dart';
import 'package:taskhub/models/task_model.dart';
import 'package:taskhub/models/user_model.dart';
import 'package:taskhub/services/database_service.dart';
import 'package:taskhub/styles/text_styles.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    final tasks = Provider.of<List<Task>>(context);
    return tasks.isEmpty
        ? const Center(
            child: Text(
              'No tasks available.\n\nYou can add a task pressing the + button in the bottom right corner.',
              style: CustomTextStyle.primaryTextRegular,
              textAlign: TextAlign.center,
            ),
          )
        : SlidableAutoCloseBehavior(
            closeWhenOpened: true,
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskTile(
                  task: tasks[index],
                  onCheckboxChanged: (newValue) async =>
                      await DatabaseService(uid: user!.uid)
                          .updateTaskStatus(tasks[index].id, newValue),
                  onSlidablePressed: () async =>
                      await DatabaseService(uid: user!.uid)
                          .deleteTask(tasks[index].id),
                );
              },
            ),
          );
  }
}
