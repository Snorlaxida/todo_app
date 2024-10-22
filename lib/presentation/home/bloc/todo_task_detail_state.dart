abstract class TodoTaskDetailState {}

class Initial extends TodoTaskDetailState {}

class Loading extends TodoTaskDetailState {}

class TodoTaskReady extends TodoTaskDetailState {}

class TodoTaskFailure extends TodoTaskDetailState {
  final String errorMessage;

  TodoTaskFailure({required this.errorMessage});
}
