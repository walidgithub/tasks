abstract class HomeState{}

class HomeInitial extends HomeState{}

class LoadingHomeState extends HomeState{}
class LoadedHomeState extends HomeState{}
class ErrorLoadingHomeState extends HomeState{
  String errorText;

  ErrorLoadingHomeState(this.errorText);
}

class LoadingTasksState extends HomeState{}
class LoadedTasksState extends HomeState{}
class ErrorLoadingTasksState extends HomeState{
  String errorText;

  ErrorLoadingTasksState(this.errorText);
}

class LoadingCategoriesState extends HomeState{}
class LoadedCategoriesState extends HomeState{}
class ErrorLoadingCategoriesState extends HomeState{
  String errorText;

  ErrorLoadingCategoriesState(this.errorText);
}
