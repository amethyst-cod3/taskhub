import 'package:flutter/material.dart';
import 'package:taskhub/models/task_model.dart';
import 'package:taskhub/styles/colors.dart';
import 'package:taskhub/styles/text_styles.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColor.lightwhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          //Checkbox(value: task.isCompleted, onChanged: () {}),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: CustomTextStyle.taskTileTitle,
                ),
                const SizedBox(height: 8),
                Text(
                  task.description,
                  style: CustomTextStyle.taskTileDescription,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
