import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/components/buttons.dart';
import 'package:taskhub/components/textfields.dart';
import 'package:taskhub/models/user_model.dart';
import 'package:taskhub/services/database_service.dart';
import 'package:taskhub/styles/colors.dart';
import 'package:taskhub/styles/text_styles.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<StatefulWidget> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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
                      'Add Task',
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
                            hintText: 'Title...',
                            isTaskField: true,
                          ),
                          CustomTextField.secondary(
                            textController: descriptionController,
                            hintText: 'Description...',
                            minLines: null,
                            maxLines: null,
                            expands: true,
                            isTaskField: true,
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: CustomButton.primary(
                          text: 'Add task',
                          color: CustomColor.blue,
                          onTap: () async {
                            if (titleController.text.isNotEmpty) {
                              if (descriptionController.text.isNotEmpty) {
                                await DatabaseService(uid: user!.uid).addTask(
                                    'newtask',
                                    titleController.text.trim(),
                                    descriptionController.text.trim(),
                                    false);
                                if (context.mounted) context.pop();
                              } else {
                                _showErrorSnackBar(
                                    context, 'Description is empty.');
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
