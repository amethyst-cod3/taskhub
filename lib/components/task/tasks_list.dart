import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/components/task/task_tile.dart';
import 'package:taskhub/models/task_model.dart';
import 'package:taskhub/models/user_model.dart';
import 'package:taskhub/services/database_service.dart';
import 'package:taskhub/styles/colors.dart';
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
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'No tasks available.\n\nYou can add a task pressing the + button in the bottom right corner.',
                style: CustomTextStyle.primaryTextRegular,
                textAlign: TextAlign.center,
              ),
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
                      await _showDeleteConfirmationDialog(tasks[index]),
                );
              },
            ),
          );
  }

  Future<void> _showDeleteConfirmationDialog(Task task) async {
    final user = Provider.of<UserModel?>(context, listen: false);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.delete_outline),
          backgroundColor: CustomColor.customwhite,
          title: const Text(
            'Delete task',
            style: CustomTextStyle.taskTileTitle,
          ),
          content: const Text(
            'Are you sure you want to delete this task?',
            style: CustomTextStyle.taskTileDescription,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: CustomTextStyle.secondaryButtonRegular,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Confirm',
                style: CustomTextStyle.tertiaryButtonRegularAlternative,
              ),
              onPressed: () async {
                await DatabaseService(uid: user!.uid).deleteTask(task.id);
                if (context.mounted) Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
