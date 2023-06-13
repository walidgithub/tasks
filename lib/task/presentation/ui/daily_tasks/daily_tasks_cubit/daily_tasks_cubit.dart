import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/daily_task_model.dart';
import '../../../../domain/repositories/task_repo_imp.dart';
import 'daily_tasks_state.dart';

class DailyTasksCubit extends Cubit<DailyTasksState> {
  DailyTasksCubit(this.taskRepoImp) : super(DailyTasksInitial());

  TaskRepoImp taskRepoImp;

  static DailyTasksCubit get(context) => BlocProvider.of(context);

  var dailyTasks = [];

  Future<void> executeLoadingTasksByCategory(String category, String date) async {
    // '2023-06-12T00:00:00.000'
    try {
      emit(LoadingDailyTasksState());
      await loadDailyTasksByCategory(category, date).then((allDailyTasks) {
        for (var v in allDailyTasks) {
          dailyTasks.add(v.toMap());
        }
        print(dailyTasks);
      });
      emit(LoadedDailyTasksState());
    } catch (e) {
      emit(ErrorLoadingDailyTasksState(e.toString()));
    }
  }

  Future<List<DailyTaskModel>> loadDailyTasksByCategory(String category, String date) async {
    final res = await taskRepoImp.loadDailyTasksByCategory(category, date);
    return res;
  }
}
