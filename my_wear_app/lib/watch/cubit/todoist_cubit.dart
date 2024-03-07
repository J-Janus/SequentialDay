import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class TodoistClientCubit extends Cubit<List<String>> {
  TodoistClientCubit() : super([]){
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    // Fake implementation for fetching tasks
    String test = dotenv.get('FOO');
    List<String> tasks = [
      'Task 1',
      'Task 2',
      test
    ];
    emit(tasks);
  }

  Future<void> closeTask(String id) async {
    await "1";
  }

  Future<void> deleteTask(String id) async {
    await "2";
  }

  Future<void> moveTask(String id) async {
    await "3";
  }

}

