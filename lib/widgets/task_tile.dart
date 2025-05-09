import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/task.dart';
import 'package:flutter_application_1/utils/colors.dart';


class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onToggleComplete;
  final VoidCallback onDelete;

  const TaskTile({
    super.key,
    required this.task,
    required this.onToggleComplete,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDueSoon = task.dueDate.difference(DateTime.now()).inDays <= 1;

    return Card(
      color: isDueSoon ? Colors.red[100] : Colors.white,
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isDone ? TextDecoration.lineThrough : null,
            color: task.isDone ? Colors.grey : Colors.black,
          ),
        ),
        subtitle: Text("${task.description} - ${task.category}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(value: task.isDone, onChanged: (_) => onToggleComplete()),
            IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
          ],
        ),
      ),
    );
  }
}
