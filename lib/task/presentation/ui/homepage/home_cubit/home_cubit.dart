import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/daily_task_model.dart';
import '../../../../domain/entities/task_days_model.dart';
import '../../../../domain/repositories/task_repo_imp.dart';
import '../../../../shared/preferences/dbHelper.dart';
import '../../../di/di.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.taskRepoImp) : super(HomeInitial());

  TaskRepoImp taskRepoImp;

  static HomeCubit get(context) => BlocProvider.of(context);

  Set<String> categories = {};

  var tasks = [];

  List<double> categoryPercent = [];
  List<int> itemsCount = [];

  // -----------------------------------------------------------------------------
  Future<void> loadDailyTasksByCategory(String category, String date) async {
    try {
      emit(LoadingTasksState());
      await getAllTasks(category, date).then((allTasks) {
        for (var v in allTasks) {
          tasks.add(v.toMap());
        }
        // print(tasks);
      });
      emit(LoadedTasksState());
    } catch (e) {
      emit(ErrorLoadingTasksState(e.toString()));
    }
  }

  Future<List<DailyTaskModel>> getAllTasks(String category, String date) async {
    final res = await taskRepoImp.loadDailyTasksByCategory(category, date);
    return res;
  }

  // -----------------------------------------------------------------------------
  Future<void> loadTasksCategories(String date) async {
    try {
      emit(LoadingCategoriesState());
      await getDailyCategories(date).then((allDailyCategories) async {
        categories = allDailyCategories.toSet();

        for (var category in categories) {
          await getItemsCountInCategory(category, date).then((count) {
            itemsCount.add(count);
          });

          await getCategoryPercent(category, date).then((percent) {
            categoryPercent.add(percent);
          });
        }
      });

      emit(LoadedCategoriesState());
    } catch (e) {
      emit(ErrorLoadingCategoriesState(e.toString()));
    }
  }

  Future<List<String>> getDailyCategories(String date) async {
    final res = await taskRepoImp.getDailyCategories(date);
    return res;
  }

  // -----------------------------------------------------------------------------
  Future<double> getCategoryPercent(String category, String date) async {
    final categoryPercent =
        await taskRepoImp.getPercentForCategory(category, date);
    return categoryPercent;
  }

  // -----------------------------------------------------------------------------
  Future<int> getItemsCountInCategory(String category, String date) async {
    final itemsCount =
        await taskRepoImp.getItemsCountInCategory(category, date);
    return itemsCount;
  }
}
