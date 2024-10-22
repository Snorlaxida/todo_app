class TodoTask {
  final String? docId;
  final String userId;
  final String title;
  final String description;
  final DateTime? deadline;
  final bool isCompleted;

  TodoTask({
    this.docId,
    required this.userId,
    required this.title,
    required this.description,
    required this.deadline,
    required this.isCompleted,
  });
}
