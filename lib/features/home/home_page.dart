import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/home/tasks_list.dart';
import 'package:taskhub/models/task_model.dart';
import 'package:taskhub/services/auth_service.dart';
import 'package:taskhub/services/database_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Task>>.value(
      initialData: const [],
      value: DatabaseService().tasks,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  await _authService.signOut(context);
                },
                child: const Text('HomePage'),
              ),
              const TasksList(),
            ],
          ),
        ),
      ),
    );
  }
}
