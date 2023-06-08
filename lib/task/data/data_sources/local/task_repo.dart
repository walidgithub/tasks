import '../../../domain/entities/daily_task_model.dart';
import '../../../domain/entities/nested_task_model.dart';
import '../../../domain/entities/task_days_model.dart';

abstract class TaskRepository {
  Future<List<DailyTaskModel>> getAllTasks(String category);
  Future<List<NestedTaskModel>> getAllNestedTasks(int taskId);
  Future<List<String>> getTasksNames();
  Future<DailyTaskModel> updateOldTask(int taskId);
  Future<void> addTask(DailyTaskModel dailyTaskModel);
  Future<void> addTaskDay(TaskDaysModel taskDays);
  Future<void> addNestedTask(NestedTaskModel nestedTaskModel, TaskDaysModel taskDays);
  Future<void> deleteTask(int taskId);
}