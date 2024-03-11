import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_wear_app/taskClient/TaskClient.dart';

class TodoistTaskClient extends TaskClient{
  
  final _token = dotenv.env['TODOIST_API_TOKEN'];

  @override
  Future<void> addTask(String content, DateTime start_time, DateTime end_time) {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<void> closeTask(String id) {
    // TODO: implement closeTask
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTask(String id) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<List<String>> fetchTasks() async {
  // TODO: implement fetchTasks
  return Future.value([_token as String]);
  }

  @override
  Future<void> moveToNextDay(String id) {
    // TODO: implement moveToNextDay
    throw UnimplementedError();
  }

  @override
  Future<void> reopenTask(String id) {
    // TODO: implement reopenTask
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(String id, DateTime start_time, DateTime end_time) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}