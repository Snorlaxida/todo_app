import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/coreUI/widgets/lang_change_button.dart';
import 'package:todo_app/coreUI/widgets/theme_change_button.dart';
import 'package:todo_app/model/todo_task.dart';
import 'package:todo_app/presentation/home/bloc/todo_list_cubit.dart';
import 'package:todo_app/presentation/home/bloc/todo_list_state.dart';
import 'package:todo_app/presentation/home/widgets/todo_task_tile.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<TodoListCubit>().getTodoList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do App'),
        centerTitle: true,
        leading: const ThemeChangeButton(),
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<TodoListCubit>().logout();
              if (context.mounted) {
                context.goNamed('SignIn');
              }
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed('Details');
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.yellow[300],
        child: const Icon(
          Icons.add,
        ),
      ),
      body: BlocBuilder<TodoListCubit, TodoListState>(
        builder: (context, toDoListState) {
          if (toDoListState is LoadingTodoList) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (toDoListState is TodoListEmpty) {
            return const Center(
              child: Text('You have no tasks :)'),
            );
          }
          if (toDoListState is TodoListFailure) {
            return Center(
              child: Text(toDoListState.errorMessage),
            );
          }
          if (toDoListState is TodoListReady) {
            final List<TodoTask> taskList = toDoListState.todoTasks;
            return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                if (index == taskList.length - 1) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: TodoTaskTile(
                      docId: taskList[index].docId!,
                      title: taskList[index].title,
                      description: taskList[index].description,
                      isCompleted: taskList[index].isCompleted,
                      deadline: taskList[index].deadline,
                    ),
                  );
                }
                return TodoTaskTile(
                  docId: taskList[index].docId!,
                  title: taskList[index].title,
                  description: taskList[index].description,
                  isCompleted: taskList[index].isCompleted,
                  deadline: taskList[index].deadline,
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
