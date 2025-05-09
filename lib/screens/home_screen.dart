import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/task_data.dart';
import 'package:flutter_application_1/widgets/task_tile.dart';
import 'package:flutter_application_1/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Asian College TO-DO App"),
        backgroundColor: AppColors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: AppColors.gold,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: TaskData.tasks.length,
        itemBuilder: (context, index) {
          return TaskTile(
            task: TaskData.tasks[index],
            onToggleComplete: () {
              setState(() {
                TaskData.tasks[index].isDone = !TaskData.tasks[index].isDone;
              });
            },
            onDelete: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Delete Task"),
                  content: const Text("Are you sure you want to delete this task?"),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          TaskData.tasks.removeAt(index);
                        });
                        Navigator.pop(context);
                      },
                      child: const Text("Delete"),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
