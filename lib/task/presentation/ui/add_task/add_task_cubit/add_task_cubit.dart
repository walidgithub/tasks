import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/daily_task_model.dart';
import '../../../../domain/entities/task_days_model.dart';
import '../../../../domain/repositories/task_repo_imp.dart';
import 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit(this.taskRepoImp) : super(AddTaskInitial());

  TaskRepoImp taskRepoImp;

  static AddTaskCubit get(context) => BlocProvider.of(context);

  Set<String> tasksNames = {};
  Set<String> categories = {};

  // show task by id-----------------------------------------------------------------------------
  Future<void> loadTaskById(int taskId) async {
    try {
      emit(LoadingPrevTask());

      final res = await taskRepoImp.showTask(taskId);

      await loadTaskDayByMainTaskId(taskId);

      print(res.toMap());

      emit(LoadedPrevTask(res));
    } catch (e) {
      emit(ErrorLoadingPrevTask(e.toString()));
    }
  }

  // show task day by id-----------------------------------------------------------------------------
  Future<void> loadTaskDayByMainTaskId(int taskId) async {
    try {

      emit(LoadingPrevTaskDay());

      final res = await taskRepoImp.showTaskDays(taskId);

      emit(LoadedPrevTaskDay(res));
    } catch (e) {
      emit(ErrorLoadingPrevTaskDay(e.toString()));
    }
  }

  // load tasks names-----------------------------------------------------------------------------
  Future<void> loadTasksNames() async {
    try {
      emit(LoadingTasksNamesState());
      await getTasksNames().then((allTasksNames) {
        tasksNames = allTasksNames.toSet();
      });
      emit(LoadedTasksNamesState());
    } catch (e) {
      emit(ErrorLoadingTasksNamesState(e.toString()));
    }
  }

  Future<List<String>> getTasksNames() async {
    final res = await taskRepoImp.getTasksNames();
    return res;
  }

  // load categories----------------------------------------------------------------------------
  Future<void> loadCategories() async {
    try {
      emit(LoadingCategoriesState());
      await getAllCategories().then((allCategories) {
        categories = allCategories.toSet();
      });
      emit(LoadedCategoriesState());
    } catch (e) {
      emit(ErrorLoadingCategoriesState(e.toString()));
    }
  }

  Future<List<String>> getAllCategories() async {
    final res = await taskRepoImp.getAllCategories();
    return res;
  }

  // add new task----------------------------------------------------------------------------
  Future<void> addNewTask(DailyTaskModel dailyTaskModel) async {
    try {
      await taskRepoImp.addTask(dailyTaskModel);
      emit(NewTaskSavedState());
    } catch (e) {
      emit(AddTaskErrorState(e.toString()));
    }
  }

  // update new task----------------------------------------------------------------------------
  Future<void> updateTask(DailyTaskModel dailyTaskModel, int taskId) async {
    try {
      await taskRepoImp.updateOldTask(dailyTaskModel, taskId);
      emit(UpdateTaskState());
    } catch (e) {
      emit(ErrorUpdateTaskState(e.toString()));
    }
  }

  // delete task----------------------------------------------------------------------------
  Future<void> deleteTask(int taskId) async {
    try {
      await taskRepoImp.deleteTask(taskId);
      await taskRepoImp.deleteTaskDay(taskId);
      emit(DeleteTaskState());
    } catch (e) {
      emit(ErrorDeleteTaskState(e.toString()));
    }
  }

  // add new task day----------------------------------------------------------------------------
  Future<void> addTaskDay(TaskDaysModel taskDays) async {
    try {
      await taskRepoImp.addTaskDay(taskDays);
      emit(NewTaskDaySavedState());
    } catch (e) {
      emit(AddTaskDayErrorState(e.toString()));
    }
  }

  // delete task day----------------------------------------------------------------------------
  Future<void> deleteTaskDays(int taskId) async {
    try {
      await taskRepoImp.deleteTaskDay(taskId);
      emit(DeleteTaskDaysState());
    } catch (e) {
      emit(ErrorDeleteTaskDaysState(e.toString()));
    }
  }
}
