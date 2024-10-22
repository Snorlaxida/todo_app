import 'package:todo_app/model/todo_task.dart';

abstract class TodoListState {}

class Initial extends TodoListState {}

class LoadingTodoList extends TodoListState {}

class TodoListEmpty extends TodoListState {}

class TodoListReady extends TodoListState {
  final List<TodoTask> todoTasks;

  TodoListReady({required this.todoTasks});
}

class TodoListFailure extends TodoListState {
  final String errorMessage;

  TodoListFailure({required this.errorMessage});
}
