import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TodoistClientCubit extends Cubit<List<String>> {
  TodoistClientCubit() : super([]){
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    // Fake implementation for fetching tasks
    List<String> tasks = [
      'Task 1',
      'Task 2',
      'Task 3'
    ];
    emit(tasks);
  }
}
