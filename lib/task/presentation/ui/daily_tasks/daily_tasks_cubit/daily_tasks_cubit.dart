import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/daily_task_model.dart';
import '../../../../domain/entities/task_days_model.dart';
import '../../../../domain/repositories/task_repo_imp.dart';
import 'daily_tasks_state.dart';

class DailyTasksCubit extends Cubit<DailyTasksState> {
  DailyTasksCubit(this.taskRepoImp) : super(DailyTasksInitial());

  TaskRepoImp taskRepoImp;

  static DailyTasksCubit get(context) => BlocProvider.of(context);

  var dailyTasks = [];

  Future<void> executeLoadingTasksByCategory(
      String category, String date) async {
    try {
      emit(LoadingDailyTasksState());

      await loadDailyTasksByCategory(category, date).then((allDailyTasks) {
        for (var v in allDailyTasks) {
          dailyTasks.add(v.toMap());
        }
      });
      emit(LoadedDailyTasksState());
    } catch (e) {
      emit(ErrorLoadingDailyTasksState(e.toString()));
    }
  }

  Future<List<DailyTaskModel>> loadDailyTasksByCategory(
      String category, String date) async {
    final res = await taskRepoImp.loadDailyTasksByCategory(category, date);
    return res;
  }

  Future<void> toggleDone(MakeTaskDoneModel makeItDone, int taskId) async {
    try {
      await taskRepoImp.toggleDone(makeItDone, taskId);
      var index = dailyTasks.indexWhere((element) => element['id'] == taskId);

      if (dailyTasks[index]['done'] == 1){
        dailyTasks[index]['done'] = 0;
        emit(UnMakeTaskDoneState());
      }else {
        dailyTasks[index]['done'] = 1;
        emit(MakeTaskDoneState());
      }
    } catch (e) {
      emit(ErrorMakeTaskDoneState(e.toString()));
    }
  }

  Future<void> togglePinned(TogglePinnedModel togglePinned, int taskId) async {
    try {
      await taskRepoImp.togglePinned(togglePinned, taskId);
      emit(PinTaskState());
    } catch (e) {
      emit(ErrorPinTaskState(e.toString()));
    }
  }

  Future<void> updateTask(
      DailyTaskModel dailyTaskModel, TaskDaysModel taskDays, int taskId) async {
    try {
      await taskRepoImp.updateOldTask(dailyTaskModel, taskId);
      emit(UpdateTaskState());
    } catch (e) {
      emit(ErrorUpdateTaskState(e.toString()));
    }
  }

  Future<void> deleteTask(int taskId) async {
    try {
      await taskRepoImp.deleteTask(taskId);
      await taskRepoImp.deleteTaskDay(taskId);

      var index = dailyTasks.indexWhere((element) => element['id'] == taskId);

      dailyTasks.removeAt(index);

      emit(DeleteTaskState());
    } catch (e) {
      emit(ErrorDeleteTaskState(e.toString()));
    }
  }
}
