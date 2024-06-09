import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/home/tasks_list.dart';
import 'package:taskhub/models/task_model.dart';
import 'package:taskhub/models/user_model.dart';
import 'package:taskhub/services/database_service.dart';
import 'package:taskhub/styles/colors.dart';
import 'package:taskhub/styles/text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                    SizedBox(
                      width: w,
                      height: h * 0.10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              SizedBox(
                                width: 18,
                              ),
                              Text(
                                'Home',
                                style: CustomTextStyle.menuTitle,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.person),
                                color: CustomColor.lightwhite,
                                onPressed: () => context.push('/profilePage'),
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
            color: CustomColor.lightwhite,
          ),
          onPressed: () => context.push('/addTaskPage'),
        ),
      ),
    );
  }
}
