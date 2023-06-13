import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/daily_task_model.dart';
import '../../../../domain/entities/task_days_model.dart';
import '../../../../domain/repositories/task_repo_imp.dart';
import 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit(this.taskRepoImp) : super(AddTaskInitial());

  TaskRepoImp taskRepoImp;

  static AddTaskCubit get(context) => BlocProvider.of(context);

  List<String> tasksNames = [];

  Future<void> loadTasksNames() async {
    try {
      emit(LoadingTasksNamesState());
      await getTasksNames().then((allTasksNames) {
        tasksNames = allTasksNames;
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

  Future<void> addNewTask(DailyTaskModel dailyTaskModel) async {
    await taskRepoImp.addTask(dailyTaskModel);
    emit(NewTaskSavedState());
  }

  Future<void> addTaskDay(TaskDaysModel taskDays) async {
    await taskRepoImp.addTaskDay(taskDays);
    emit(NewTaskDaySavedState());
  }

  Future<List<DailyTaskModel>> loadDailyTasksByCategory(String category, String date) async {
    final res = await taskRepoImp.loadDailyTasksByCategory(category, date);
    return res;
  }
}
