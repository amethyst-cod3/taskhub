import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:taskhub/models/task_model.dart';
import 'package:taskhub/styles/colors.dart';
import 'package:taskhub/styles/text_styles.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.onCheckboxChanged,
    required this.onSharePressed,
    required this.onDeletePressed,
  });

  final Task task;
  final Function(bool) onCheckboxChanged;
  final Function() onSharePressed;
  final Function() onDeletePressed;

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
  void didUpdateWidget(TaskTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isCompleted != widget.task.isCompleted) {
      setState(() {
        _isCompleted = widget.task.isCompleted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              backgroundColor: CustomColor.lightwhite,
              foregroundColor: CustomColor.blue,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              icon: Icons.share,
              onPressed: (context) async => widget.onSharePressed(),
            ),
            SlidableAction(
              backgroundColor: CustomColor.lightwhite,
              foregroundColor: CustomColor.purple,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              icon: Icons.delete_sweep,
              onPressed: (context) async => widget.onDeletePressed(),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () => context.push('/editTaskPage/${widget.task.id}',
              extra: widget.task),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color:
                  _isCompleted ? CustomColor.lightblue : CustomColor.lightwhite,
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
                  onChanged: _isCompleted
                      ? null
                      : (newValue) async {
                          await _showConfirmationDialog(newValue!);
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: _isCompleted
                            ? CustomTextStyle.completedTaskTileDescription
                            : CustomTextStyle.taskTileDescription,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  DateFormat('dd MMM').format(widget.task.creationDate),
                  style: _isCompleted
                      ? CustomTextStyle.completedTaskTileCreated
                      : CustomTextStyle.taskTileCreated,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showConfirmationDialog(bool newValue) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.warning_amber),
          backgroundColor: CustomColor.customwhite,
          title: const Text(
            'Complete task',
            style: CustomTextStyle.taskTileTitle,
          ),
          content: const Text(
            'Are you sure you want to mark this task as completed?',
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
                style: CustomTextStyle.tertiaryButtonRegular,
              ),
              onPressed: () {
                setState(() {
                  _isCompleted = newValue;
                });
                widget.onCheckboxChanged(_isCompleted);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
