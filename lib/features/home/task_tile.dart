import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskhub/models/task_model.dart';
import 'package:taskhub/styles/colors.dart';
import 'package:taskhub/styles/text_styles.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.onCheckboxChanged,
  });

  final Task task;
  final Function(bool) onCheckboxChanged;

  @override
  State<StatefulWidget> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.task.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.push('/editTaskPage/${widget.task.id}', extra: widget.task),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _isCompleted ? CustomColor.lightblue : CustomColor.lightwhite,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Checkbox(
              shape: const CircleBorder(),
              side: const BorderSide(
                color: CustomColor.darkblue,
                width: 2,
              ),
              activeColor: CustomColor.lightblue,
              checkColor: CustomColor.customwhite,
              value: _isCompleted,
              onChanged: (newValue) async {
                setState(() {
                  _isCompleted = newValue!;
                });
                widget.onCheckboxChanged(_isCompleted);
              },
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.title,
                    style: _isCompleted
                        ? CustomTextStyle.completedTaskTileTitle
                        : CustomTextStyle.taskTileTitle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.task.description,
                    style: _isCompleted
                        ? CustomTextStyle.completedTaskTileDescription
                        : CustomTextStyle.taskTileDescription,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
