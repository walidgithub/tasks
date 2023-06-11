import 'package:tasks/task/domain/entities/nested_task_model.dart';
import 'package:tasks/task/domain/entities/task_days_model.dart';

import '../../data/data_sources/local/task_repo.dart';
import '../../presentation/di/di.dart';
import '../../shared/preferences/dbHelper.dart';
import '../entities/daily_task_model.dart';

class TaskRepoImp extends TaskRepository {
  final DbHelper _dbHelper;

  TaskRepoImp(this._dbHelper) {
    _dbHelper.database;
  }

  @override
  Future<void> addTask(DailyTaskModel dailyTaskModel) async {
    await _dbHelper.createTask(dailyTaskModel);
    await getTasksNames();
  }

  @override
  Future<void> addTaskDay(TaskDaysModel taskDays) async {
    await _dbHelper.createTaskDays(taskDays);
  }

  @override
  Future<void> addNestedTask(
      NestedTaskModel nestedTaskModel, TaskDaysModel taskDays) async {
    await _dbHelper.createNestedTask(nestedTaskModel);
    await _dbHelper.createTaskDays(taskDays);
  }

  @override
  Future<void> deleteTask(int taskId) async {
    await _dbHelper.deleteTask(taskId);
    await _dbHelper.deleteTaskDays(taskId);
  }

  @override
  Future<DailyTaskModel> updateOldTask(int taskId) async {
    throw UnimplementedError();
  }

  @override
  Future<List<DailyTaskModel>> getAllTasks(String category, String date) async {
    final res = await _dbHelper.showAllTasks(category, date);
    return res;
  }

  @override
  Future<List<NestedTaskModel>> getAllNestedTasks(int taskId) {
    // TODO: implement getNestedTasks
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getTasksNames() async {
    final res = await _dbHelper.getAllTasksNames();
    return res;
  }

  @override
  Future<List<String>> getDailyCategories(String date) async {
    final res = await _dbHelper.getDailyTasksCategories(date);
    return res;
  }

  @override
  Future<double> getPercentForCategory(String category) async {
    final res = await _dbHelper.getCategoriesPercent(category);
    return res;
  }

  @override
  Future<int> getItemsCountInCategory(String category, String date) async {
    final res = await _dbHelper.getCountOfCategoryItems(category, date);
    return res;
  }
}
