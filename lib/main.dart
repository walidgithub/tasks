import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks/task/presentation/di/di.dart';
import 'package:tasks/task/presentation/ui/add_task/add_task.dart';
import 'package:tasks/task/presentation/ui/add_task/cubit/add_task_cubit.dart';
import 'package:tasks/task/presentation/ui/homepage/homepage_view.dart';
import 'package:tasks/task/presentation/ui/nested_details/nested_details.dart';
import 'package:tasks/task/presentation/ui/on_boarding/onborading_view.dart';
import 'package:tasks/task/presentation/ui/splash_view/splash_view.dart';
import 'package:tasks/task/presentation/ui/tasks_by_category/tasks_by_category.dart';
import 'package:tasks/task/shared/constant/language_manager.dart';
import 'package:tasks/task/shared/style/theme_constants.dart';
import 'package:tasks/task/shared/style/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator().init();
  await EasyLocalization.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(EasyLocalization(
      supportedLocales: const [ARABIC_LOCAL, ENGLISH_LOCAL],
      path: ASSET_PATH_LOCALISATIONS,
      child: Phoenix(child: const MyApp())));
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            title: 'Tasks',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: _themeManager.themeMode,
            home: AddTask(),
          );
        });
  }
}
