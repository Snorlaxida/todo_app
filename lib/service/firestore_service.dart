import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/model/todo_task.dart';

class FirestoreService {
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addTask(TodoTask task) {
    return tasks.add({
      'title': task.title,
      'description': task.description,
      'isComplited': task.isCompleted,
      'deadline': task.deadline,
      'userId': task.userId
    });
  }

  Stream<QuerySnapshot> getTasksStream() {
    final tasksStream = tasks
        .where('userId', isEqualTo: userId)
        .orderBy(
          'title',
          descending: false,
        )
        .snapshots();
    return tasksStream;
  }

  Future<void> updateTask(String docId, TodoTask newTask) {
    return tasks.doc(docId).update({
      'title': newTask.title,
      'description': newTask.description,
      'isComplited': newTask.isCompleted,
      'deadline': newTask.deadline,
    });
  }

  Future<void> updateIsCompleted(String docId, bool newValue) {
    return tasks.doc(docId).update({
      'isComplited': newValue,
    });
  }

  Future<void> deleteTask(String docId) {
    return tasks.doc(docId).delete();
  }
}
