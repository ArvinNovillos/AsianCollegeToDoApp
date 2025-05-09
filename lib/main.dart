import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/add_edit_task_screen.dart';
import 'package:flutter_application_1/models/task.dart';
import 'package:flutter_application_1/utils/colors.dart';

void main() {
  runApp(MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asian College TO-DO App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.blue,
          secondary: AppColors.gold,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.gold,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      home: HomeScreen(),
      routes: {
        '/addTask': (context) => const AddEditTaskScreen(),
      },
      onGenerateRoute: (settings) {
        // Handle dynamic route for editing
        if (settings.name == '/editTask') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => AddEditTaskScreen(
              taskToEdit: args['task'],
              index: args['index'],
            ),
          );
        }
        return null;
      },
    );
  }
}
