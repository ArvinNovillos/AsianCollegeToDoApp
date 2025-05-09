class Task {
  String title;
  String description;
  DateTime dueDate;
  String category;
  bool isDone;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.category,
    this.isDone = false,
  });
}

