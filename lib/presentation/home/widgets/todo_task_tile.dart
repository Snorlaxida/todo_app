import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/presentation/home/bloc/todo_list_cubit.dart';

class TodoTaskTile extends StatelessWidget {
  const TodoTaskTile({
    super.key,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.deadline,
    required this.docId,
  });

  final String docId;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime? deadline;

  String _formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30,
        left: 20,
        right: 20,
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                context.read<TodoListCubit>().deleteTodoTask(docId);
              },
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(15),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            context.goNamed(
              'UpdateDetails',
              extra: {
                'oldTitle': title,
                'oldDateTime': deadline,
                'docId': docId,
                'isCompleted': isCompleted,
                'oldDescription': description,
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: isCompleted,
                  onChanged: (value) {
                    context.read<TodoListCubit>().updateIsCompleted(
                          docId,
                          value!,
                        );
                  },
                  checkColor: Colors.black,
                  activeColor: Colors.white,
                  side: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: Colors.white,
                    decorationThickness: 2,
                  ),
                ),
                const Spacer(),
                Text(deadline != null ? _formatDateTime(deadline!) : '')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
