
import 'package:flutter/material.dart';
import 'package:tasks/task/presentation/ui/add_task/add_task.dart';
import 'package:tasks/task/presentation/ui/homepage/homepage_view.dart';
import 'package:tasks/task/presentation/ui/nested_tasks/nested_tasks.dart';
import 'package:tasks/task/presentation/ui/on_boarding/onborading_view.dart';
import 'package:tasks/task/presentation/ui/splash_view/splash_view.dart';

import '../../shared/constant/strings_manager.dart';
import '../ui/category/category.dart';


class Routes {
  static const String mainRoute = "/home";
  static const String splashRoute = "/splash";
  static const String onBoarding = "/onBoarding";
  static const String addTask = "/addTask";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const HomePageView());
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoarding());
      case Routes.addTask:
        return MaterialPageRoute(builder: (_) => AddTask());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.noRouteFound),
          ),
          body: const Center(child: Text(AppStrings.noRouteFound)),
        ));
  }
}