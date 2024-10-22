import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/model/todo_task.dart';
import 'package:todo_app/presentation/home/bloc/todo_task_detail_cubit.dart';
import 'package:todo_app/presentation/home/bloc/todo_task_detail_state.dart';

class TodoDetailScreen extends StatefulWidget {
  const TodoDetailScreen({super.key});

  @override
  State<TodoDetailScreen> createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  DateTime? dateTime;

  void getDateTime(DateTime? selectedDateTime) {
    setState(() {
      dateTime = selectedDateTime;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TitleTextField(titleController: titleController),
              const SizedBox(height: 30),
              DescriptionTextField(
                  descriptionController: descriptionController),
              const SizedBox(height: 30),
              DateTimeSelector(
                onDateTimeChanged: getDateTime,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  final String userId = FirebaseAuth.instance.currentUser!.uid;
                  context.read<TodoTaskDetailCubit>().createTodoTask(
                        TodoTask(
                          userId: userId,
                          title: titleController.text,
                          description: descriptionController.text,
                          isCompleted: false,
                          deadline: dateTime,
                        ),
                      );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff0D6EFD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  minimumSize: const Size(double.infinity, 60),
                  elevation: 0,
                ),
                child: BlocConsumer<TodoTaskDetailCubit, TodoTaskDetailState>(
                  listener: (context, state) {
                    if (state is TodoTaskReady) {
                      context.pop();
                    }
                    if (state is TodoTaskFailure) {
                      Fluttertoast.showToast(
                        msg: state.errorMessage,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.SNACKBAR,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 14,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is Loading) {
                      return const CircularProgressIndicator();
                    }
                    return const Text('Add');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateTimeSelector extends StatefulWidget {
  const DateTimeSelector({
    super.key,
    required this.onDateTimeChanged,
  });

  final ValueChanged<DateTime?> onDateTimeChanged;

  @override
  State<DateTimeSelector> createState() => _DateTimeSelectorState();
}

class _DateTimeSelectorState extends State<DateTimeSelector> {
  DateTime? selectedDateTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && context.mounted) {
      _selectTime(context, picked); // Выбираем время после выбора даты
    }
  }

  Future<void> _selectTime(BuildContext context, DateTime date) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime ?? date),
    );

    if (picked != null) {
      // Создаем DateTime объект с выбранной датой и временем
      final DateTime pickedDateTime =
          DateTime(date.year, date.month, date.day, picked.hour, picked.minute);

      // Получаем текущее время
      final DateTime now = DateTime.now();

      // Сравниваем выбранное время с текущим временем
      if (context.mounted && pickedDateTime.isBefore(now)) {
        // Если выбранное время раньше текущего, показываем сообщение
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('You cannot select a time in the past.')),
        );
      } else {
        // Если время валидное, обновляем состояние
        setState(() {
          selectedDateTime = pickedDateTime;
        });
        widget.onDateTimeChanged(selectedDateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Date and Time',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: selectedDateTime != null
                ? '${'${selectedDateTime!.toLocal()}'.split(' ')[0]} ${TimeOfDay.fromDateTime(selectedDateTime!).format(context)}'
                : 'No date and time selected',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onTap: () => _selectDate(context),
        ),
      ],
    );
  }
}

class TitleTextField extends StatelessWidget {
  const TitleTextField({
    super.key,
    required this.titleController,
  });

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Title',
          style: TextStyle(fontSize: 15),
        ),
        const SizedBox(height: 10),
        TextField(
          maxLength: 10,
          controller: titleController,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            hintText: 'Enter your task title',
            hintStyle: const TextStyle(
              color: Color(0xff6A6A6A),
              fontWeight: FontWeight.normal,
              fontSize: 15,
            ),
            fillColor: const Color(0xffF7F7F9),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }
}

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({
    super.key,
    required this.descriptionController,
  });

  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(fontSize: 15),
        ),
        const SizedBox(height: 10),
        TextField(
          maxLines: 5,
          minLines: 1,
          style: const TextStyle(color: Colors.black),
          controller: descriptionController,
          decoration: InputDecoration(
            filled: true,
            hintText: 'Enter your task title',
            hintStyle: const TextStyle(
              color: Color(0xff6A6A6A),
              fontWeight: FontWeight.normal,
              fontSize: 15,
            ),
            fillColor: const Color(0xffF7F7F9),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }
}
