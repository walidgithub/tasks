import '../../../domain/entities/daily_task_model.dart';
import '../../../domain/entities/nested_task_model.dart';
import '../../../domain/entities/task_days_model.dart';

abstract class TaskRepository {
  // Task Operations -----------------------------------------------------------------------
  Future<void> addTask(DailyTaskModel dailyTaskModel);
  Future<void> deleteTask(int taskId);
  Future<void> updateOldTask(DailyTaskModel dailyTaskModel, int taskId);
  Future<void> toggleDone(MakeTaskDoneModel makeItDone,int taskId);
  Future<List<String>> getTasksNames();
  Future<List<String>> getAllCategories();
  Future<DailyTaskModel> showTask(int taskId);

  // Home -----------------------------------------------------------------------
  Future<List<String>> getDailyCategories(String date);
  Future<double> getPercentForCategory(String category, String date);
  Future<double> getPercentForHome(String date);
  Future<int> getItemsCountInCategory(String category, String date);

  // Daily Tasks -----------------------------------------------------------------------
  Future<List<DailyTaskModel>> loadDailyTasksByCategory(String category, String date);
  Future<void> togglePinned(TogglePinnedModel togglePinned,int taskId);


  // Nested Tasks -----------------------------------------------------------------------
  Future<List<NestedTaskModel>> loadNestedTasksById(int taskId);
  Future<void> addNestedTask(
      NestedTaskModel nestedTaskModel, TaskDaysModel taskDays);

  // Task Days -----------------------------------------------------------------------
  Future<void> addTaskDay(TaskDaysModel taskDays);
  Future<void> deleteTaskDay(int taskId);
  Future<List<TaskDaysModel>> showTaskDays(int taskId);

  // Others -----------------------------------------------------------------------

}
