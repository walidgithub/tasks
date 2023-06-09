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
  List<int> pinnedItemsCount = [];

  double totalPercent = 0.0;

  // -----------------------------------------------------------------------------
  Future<void> loadTasksCategories(String date, String day) async {
    try {
      emit(LoadingCategoriesState());
      await getDailyCategories(date).then((allDailyCategories) async {
        categories = allDailyCategories.toSet();

        await loadPinnedByCategoryDay(day).then((allPinnedCategory) async {
            categories.addAll(allPinnedCategory);
        });

        for (var category in categories) {
          await getItemsCountInCategory(category, date).then((count) {
            itemsCount.add(count);
          });

          await getPinnedItemsCountInCategory(category, day).then((count) {
            pinnedItemsCount.add(count);
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

  // Total percent-----------------------------------------------------------------------------
  Future<void> loadTotalTasksPercent(String date) async {
    try{
      await getHomePercent(date).then((value) {
        totalPercent = value;
      });

      emit(LoadHomePercentState());
    }catch(e){
      emit(ErrorLoadingHomePercentState(e.toString()));
    }
  }

  Future<double> getHomePercent(String date) async {
    final homePercent =
    await taskRepoImp.getPercentForHome(date);
    return homePercent;
  }

  // Category percent-----------------------------------------------------------------------------
  Future<double> getCategoryPercent(String category, String date) async {
    final categoryPercent =
        await taskRepoImp.getPercentForCategory(category, date);
    return categoryPercent;
  }

  // Get count of category's items-----------------------------------------------------------------------------
  Future<int> getItemsCountInCategory(String category, String date) async {
    final itemsCount =
        await taskRepoImp.getItemsCountInCategory(category, date);
    return itemsCount;
  }

  // Get count of category's pinned items-----------------------------------------------------------------------------
  Future<int> getPinnedItemsCountInCategory(String category, String day) async {
    final itemsCount =
    await taskRepoImp.getCountOfCategoryPinnedItems(category, day);
    return itemsCount;
  }

  Future<List<String>> loadPinnedByCategoryDay(String day) async {
    final res = await taskRepoImp.loadPinnedByCategoryDay(day);
    return res;
  }

}
