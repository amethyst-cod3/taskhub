import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/components/buttons.dart';
import 'package:taskhub/components/textfields.dart';
import 'package:taskhub/models/task_model.dart';
import 'package:taskhub/models/user_model.dart';
import 'package:taskhub/services/database_service.dart';
import 'package:taskhub/styles/colors.dart';
import 'package:taskhub/styles/text_styles.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<StatefulWidget> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController titleController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController =
        TextEditingController(text: widget.task.description);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final user = Provider.of<UserModel?>(context);
    return Scaffold(
      backgroundColor: CustomColor.customwhite,
      body: SafeArea(
        child: SizedBox(
          width: w,
          height: h,
          child: Column(
            children: [
              SizedBox(
                width: w,
                height: h * 0.10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      color: CustomColor.darkblue,
                      onPressed: () => context.pop(),
                    ),
                    const Text(
                      'Edit Task',
                      style: CustomTextStyle.menuSecondaryTitle,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: CustomColor.lightwhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomTextField.primary(
                            textController: titleController,
                            isTaskField: true,
                            readOnly: false,
                          ),
                          CustomTextField.secondary(
                            textController: descriptionController,
                            minLines: null,
                            maxLines: null,
                            expands: true,
                            isTaskField: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Last edited:\n${DateFormat('dd MMM - HH:mm').format(widget.task.lastEdited)}',
                                  style: CustomTextStyle.taskTileCreated,
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: CustomButton.primary(
                          text: 'Apply changes',
                          color: CustomColor.blue,
                          onTap: () async {
                            if (titleController.text.isNotEmpty) {
                              if (titleController.text != widget.task.title ||
                                  descriptionController.text !=
                                      widget.task.description) {
                                await DatabaseService(uid: user!.uid).editTask(
                                  widget.task.id,
                                  titleController.text.trim(),
                                  descriptionController.text.trim(),
                                  widget.task.description,
                                );
                                if (context.mounted) context.pop();
                              } else {
                                if (context.mounted) context.pop();
                              }
                            } else {
                              _showErrorSnackBar(context, 'Title is empty.');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: CustomColor.purple,
      ),
    );
  }
}
