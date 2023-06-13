import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks/task/presentation/ui/daily_tasks/daily_tasks_cubit/daily_tasks_cubit.dart';

import '../../domain/repositories/task_repo_imp.dart';
import '../../shared/preferences/app_pref.dart';
import '../../shared/preferences/dbHelper.dart';
import '../../shared/style/theme_manager.dart';
import '../ui/add_task/add_task_cubit/add_task_cubit.dart';
import '../ui/homepage/home_cubit/home_cubit.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {

    // app prefs instance
    sl.registerLazySingleton<AppPreferences>(() => AppPreferences(sl()));

    final sharedPrefs = await SharedPreferences.getInstance();

    sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

    // Add Task Cubit
    sl.registerFactory(() => AddTaskCubit(sl()));

    // Home Cubit
    sl.registerFactory(() => HomeCubit(sl()));

    // Daily Tasks Cubit
    sl.registerFactory(() => DailyTasksCubit(sl()));

    // Theme
    sl.registerLazySingleton<ThemeManager>(() => ThemeManager());

    // dbHelper
    sl.registerLazySingleton<DbHelper>(() => DbHelper());

    // Task Repo
    sl.registerLazySingleton<TaskRepoImp>(() => TaskRepoImp(sl()));
  }
}