import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/task.dart';
import 'package:flutter_application_1/data/task_data.dart';
import 'package:flutter_application_1/utils/colors.dart';

class AddEditTaskScreen extends StatefulWidget {
  final Task? taskToEdit;
  final int? index;

  const AddEditTaskScreen({super.key, this.taskToEdit, this.index});

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String description;
  DateTime? dueDate;
  String category = "Academic";

  final List<String> categories = ["Academic", "Personal", "Work"];

  @override
  void initState() {
    super.initState();
    if (widget.taskToEdit != null) {
      title = widget.taskToEdit!.title;
      description = widget.taskToEdit!.description;
      dueDate = widget.taskToEdit!.dueDate;
      category = widget.taskToEdit!.category;
    } else {
      title = '';
      description = '';
      dueDate = DateTime.now();
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Task newTask = Task(
        title: title,
        description: description,
        dueDate: dueDate!,
        category: category,
      );

      setState(() {
        if (widget.taskToEdit != null && widget.index != null) {
          TaskData.tasks[widget.index!] = newTask;
        } else {
          TaskData.tasks.add(newTask);
        }
      });

      Navigator.pop(context);
    }
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        dueDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskToEdit != null ? "Edit Task" : "Add Task"),
        backgroundColor: AppColors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: title,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value!.isEmpty ? 'Enter a title' : null,
                onSaved: (value) => title = value!,
              ),
              TextFormField(
                initialValue: description,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) => value!.isEmpty ? 'Enter a description' : null,
                onSaved: (value) => description = value!,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text("Due Date: ${dueDate?.toLocal().toString().split(' ')[0]}"),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                value: category,
                items: categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) => setState(() => category = val!),
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTask,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.gold),
                child: Text(widget.taskToEdit != null ? 'Update Task' : 'Add Task'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
