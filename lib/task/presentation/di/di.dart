import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/task_repo_imp.dart';
import '../../shared/preferences/app_pref.dart';
import '../../shared/preferences/dbHelper.dart';
import '../../shared/style/theme_manager.dart';
import '../ui/add_task/cubit/add_task_cubit.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {

    // app prefs instance
    sl.registerLazySingleton<AppPreferences>(() => AppPreferences(sl()));

    final sharedPrefs = await SharedPreferences.getInstance();

    sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

    // Theme
    sl.registerLazySingleton<ThemeManager>(() => ThemeManager());

    // dbHelper
    sl.registerFactory<DbHelper>(() => DbHelper());

    // Task Repo
    sl.registerLazySingleton<TaskRepoImp>(() => TaskRepoImp(sl()));

    // Task Cubit
    sl.registerLazySingleton(() => AddTaskCubit(sl()));
  }
}