import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/home/tasks_list.dart';
import 'package:taskhub/models/task_model.dart';
import 'package:taskhub/models/user_model.dart';
import 'package:taskhub/services/auth_service.dart';
import 'package:taskhub/services/database_service.dart';
import 'package:taskhub/styles/colors.dart';
import 'package:taskhub/styles/text_styles.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final user = Provider.of<UserModel?>(context);
    final userTasks = DatabaseService(uid: user?.uid).tasks;
    return StreamProvider<List<Task>>.value(
      initialData: const [],
      value: userTasks,
      child: Scaffold(
        backgroundColor: CustomColor.blue,
        body: SafeArea(
          child: SizedBox(
            width: w,
            height: h,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: w,
                      height: h * 0.10,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Home',
                            style: CustomTextStyle.menuTitle,
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.person),
                                color: CustomColor.lightwhite,
                                onPressed: () => _authService.signOut(context),
                              ),
                              IconButton(
                                icon: const Icon(Icons.settings),
                                color: CustomColor.lightwhite,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: CustomColor.customwhite,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: const TasksList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: CustomColor.blue,
          child: const Icon(
            Icons.add,
            color: CustomColor.customwhite,
          ),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: AddTaskForm(),
                    ));
          },
        ),
      ),
    );
  }
}

// fdgdfgdf
class AddTaskForm extends StatefulWidget {
  @override
  _AddTaskFormState createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Title'),
            validator: (value) => value!.isEmpty ? 'Enter a title' : null,
            onChanged: (value) {
              setState(() {
                _title = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Description'),
            validator: (value) => value!.isEmpty ? 'Enter a description' : null,
            onChanged: (value) {
              setState(() {
                _description = value;
              });
            },
          ),
          CheckboxListTile(
            title: Text('Completed'),
            value: _isCompleted,
            onChanged: (value) {
              setState(() {
                _isCompleted = value!;
              });
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await DatabaseService(uid: user!.uid)
                    .addTask(_title, _description, _isCompleted);
                Navigator.pop(context);
              }
            },
            child: Text('Add Task'),
          ),
        ],
      ),
    );
  }
}
