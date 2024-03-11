abstract class TaskClient {
  Future<List<String>> fetchTasks(); 
  Future<void> updateTask(String id, DateTime start_time, DateTime end_time);
  Future<void> addTask(String content, DateTime start_time, DateTime end_time);
  Future<void> closeTask(String id);
  Future<void> reopenTask(String id);
  Future<void> deleteTask(String id);
  Future<void> moveToNextDay(String id);
}