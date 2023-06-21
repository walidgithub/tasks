import 'package:tasks/task/domain/entities/task_days_model.dart';

import '../../data/data_sources/local/task_repo.dart';
import '../../shared/preferences/dbHelper.dart';
import '../entities/daily_task_model.dart';

class TaskRepoImp extends TaskRepository {
  final DbHelper _dbHelper;

  TaskRepoImp(this._dbHelper) {
    _dbHelper.database;
  }

  // Task Operations -----------------------------------------------------------------------
  @override
  Future<void> addTask(DailyTaskModel dailyTaskModel) async {
    await _dbHelper.createTask(dailyTaskModel);
    await getTasksNames();
  }

  @override
  Future<void> deleteTask(int taskId) async {
    await _dbHelper.deleteTask(taskId);
  }

  @override
  Future<void> updateOldTask(DailyTaskModel dailyTaskModel, int taskId) async {
    await _dbHelper.updateTask(dailyTaskModel, taskId);
  }

  @override
  Future<void> toggleDone(MakeTaskDoneModel makeItDone, int taskId) async {
    await _dbHelper.toggleDone(makeItDone, taskId);
  }

  @override
  Future<List<String>> getTasksNames() async {
    final res = await _dbHelper.getAllTasksNames();
    return res;
  }

  @override
  Future<List<String>> getAllCategories() async {
    final res = await _dbHelper.getAllCategories();
    return res;
  }

  @override
  Future<DailyTaskModel> showTask(int taskId) async {
    final res = await _dbHelper.showTask(taskId);
    return res;
  }

  // Home -----------------------------------------------------------------------
  @override
  Future<List<String>> getDailyCategories(String date) async {
    final res = await _dbHelper.getDailyTasksCategories(date);
    return res;
  }

  @override
  Future<double> getPercentForCategory(String category, String date) async {
    final res = await _dbHelper.getCategoriesPercent(category, date);
    return res;
  }

  @override
  Future<double> getPercentForHome(String date) async {
    final res = await _dbHelper.getHomePercent(date);
    return res;
  }

  @override
  Future<int> getItemsCountInCategory(String category, String date) async {
    final res = await _dbHelper.getCountOfCategoryItems(category, date);
    return res;
  }

  // Daily Tasks -----------------------------------------------------------------------
  @override
  Future<List<DailyTaskModel>> loadDailyTasksByCategory(
      String category, String date) async {
    final res = await _dbHelper.loadDailyTasksByCategory(category, date);
    return res;
  }

  // Task Days -----------------------------------------------------------------------
  @override
  Future<void> addTaskDay(TaskDaysModel taskDays) async {
    await _dbHelper.createTaskDays(taskDays);
  }

  @override
  Future<List<TaskDaysModel>> showTaskDays(int taskId) async {
    final res = await _dbHelper.showTaskDays(taskId);
    return res;
  }

  @override
  Future<void> deleteTaskDay(int taskId) async {
    await _dbHelper.deleteTaskDays(taskId);
  }

  // Pinned Tasks -----------------------------------------------------------------------
  @override
  Future<int> getCountOfCategoryPinnedItems(String category, String day) async {
    final res = await _dbHelper.getCountOfCategoryPinnedItems(category, day);
    return res;
  }

  @override
  Future<List<TaskDaysModel>> loadPinnedTasksByCategoryAndDay(String category, String day) async {
    final res = await _dbHelper.loadPinnedTasksByCategoryAndDay(category, day);
    return res;
  }

  @override
  Future<List<String>> loadPinnedByCategoryDay(String day) async {
    final res = await _dbHelper.loadPinnedByCategoryDay(day);
    return res;
  }

  @override
  Future<DailyTaskModel> showTaskByDayAndId(int id) async {
    final res = await _dbHelper.showTaskByDayAndId(id);
    return res;
  }

  @override
  Future<void> toggleDoneByDay(
      MakeTaskDoneByDayModel makeItDone, String day, int taskId) async {
    await _dbHelper.toggleDoneByDay(makeItDone,day , taskId);
  }

  // Others -----------------------------------------------------------------------

}
