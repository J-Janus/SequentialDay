import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_wear_app/taskClient/TaskClient.dart';
import 'package:my_wear_app/taskClient/TodoistTaskClient.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class TaskCubit extends Cubit<List<String>> {
  TaskCubit() : super([]){
    fetchTasks();
  }

  TaskClient taskClient = TodoistTaskClient();

  Future<void> fetchTasks() async {
    // Fake implementation for fetching tasks
    List<String> tasks = await taskClient.fetchTasks();
    emit(tasks);
  }

  Future<void> closeTask(String id) async {
    await taskClient.closeTask(id);
  }

  Future<void> deleteTask(String id) async {
    await taskClient.deleteTask(id);
  }

  Future<void> moveTask(String id) async {
    await taskClient.moveToNextDay(id);
  }
}

